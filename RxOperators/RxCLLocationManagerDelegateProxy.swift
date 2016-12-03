//
//  RxCLLocationManagerDelegateProxy.swift
//  RxOperators
//
//  Created by yuzushioh on 12/3/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation

class RxCLLocationManagerDelegateProxy : DelegateProxy, CLLocationManagerDelegate, DelegateProxyType {
    class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let locationManager: CLLocationManager = object as! CLLocationManager
        return locationManager.delegate
    }
    
    class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let locationManager: CLLocationManager = object as! CLLocationManager
        locationManager.delegate = delegate as? CLLocationManagerDelegate
    }
}
