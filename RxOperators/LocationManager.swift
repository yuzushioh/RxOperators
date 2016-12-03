//
//  LocationManager.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation

final class LocationManager {
    static let instance = LocationManager()
    
    fileprivate let locationManager = CLLocationManager()
    
    fileprivate let authorizationStatus: Observable<CLAuthorizationStatus>
    let authorized: Observable<Bool>
    let location: Observable<CLLocationCoordinate2D>
    let error: Observable<NSError>
    
    fileprivate init() {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        authorizationStatus = Observable
            .deferred { [weak locationManager] in
                let status = CLLocationManager.authorizationStatus()
                guard let locationManager = locationManager else {
                    return Observable.of(status)
                }
                
                return locationManager
                    .rx.didChangeAuthorizationStatus
                    .startWith(status)
            }
            .distinctUntilChanged()

        authorized = authorizationStatus
            .map { status in
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    return true
                default:
                    return false
                }
            }
            .distinctUntilChanged()
        
        location = Observable
            .combineLatest(authorized, locationManager.rx.didUpdateLocations) { $0 }
            .flatMap { authorized, locations -> Observable<CLLocationCoordinate2D> in
                guard let location = locations.last, authorized else {
                    return Observable.empty()
                }
                return Observable.of(location.coordinate)
            }
        
        error = locationManager.rx.didFailWithError
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
