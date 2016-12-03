//
//  Extension+CLLocationManager.swift
//  RxOperators
//
//  Created by yuzushioh on 12/3/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

extension Reactive where Base: CLLocationManager {
    var delegate: DelegateProxy {
        return RxCLLocationManagerDelegateProxy.proxyForObject(base)
    }
    
    var didUpdateLocations: Observable<[CLLocation]> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map { a in
                return try castOrThrow([CLLocation].self, a[1])
        }
    }
    
    var didFailWithError: Observable<NSError> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didFailWithError:)))
            .map { a in
                return try castOrThrow(NSError.self, a[1])
        }
    }
    
    var didChangeAuthorizationStatus: Observable<CLAuthorizationStatus> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:)))
            .map { a in
                let number = try castOrThrow(NSNumber.self, a[1])
                return CLAuthorizationStatus(rawValue: Int32(number.intValue)) ?? .notDetermined
        }
    }
}

fileprivate func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    
    return returnValue
}
