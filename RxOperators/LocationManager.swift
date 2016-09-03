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
    
    private let locationManager = CLLocationManager()
    
    private let authorizationStatus: Observable<CLAuthorizationStatus>
    let authorized: Observable<Bool>
    let location: Observable<CLLocationCoordinate2D>
    let error: Observable<NSError>
    
    private init() {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        authorizationStatus = Observable
            .deferred { [weak locationManager] in
                let status = CLLocationManager.authorizationStatus()
                guard let locationManager = locationManager else {
                    return Observable.of(status)
                }
                
                return locationManager
                    .rx_didChangeAuthorizationStatus
                    .startWith(status)
            }
            .distinctUntilChanged()

        authorized = authorizationStatus
            .map { status in
                switch status {
                case .AuthorizedAlways, .AuthorizedWhenInUse:
                    return true
                default:
                    return false
                }
            }
            .distinctUntilChanged()
        
        location = Observable
            .combineLatest(authorized, locationManager.rx_didUpdateLocations) { $0 }
            .flatMap { authorized, locations -> Observable<CLLocationCoordinate2D> in
                guard let location = locations.last where authorized else {
                    return Observable.empty()
                }
                return Observable.of(location.coordinate)
            }
        
        error = locationManager.rx_didFailWithError
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
