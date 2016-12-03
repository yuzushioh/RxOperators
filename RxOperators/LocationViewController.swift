//
//  LocationViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.instance.authorized
            .subscribe(onNext: { authorized in
                print(authorized)
            })
            .addDisposableTo(disposeBag)
        
        LocationManager.instance.location
            .bindTo(mapView.rx_updateCoordinate)
            .addDisposableTo(disposeBag)
        
        LocationManager.instance.location
            .bindTo(locationLabel.rx_locationText)
            .addDisposableTo(disposeBag)
        
        LocationManager.instance.error
            .subscribe(onNext: { [weak self] error in
                Alert.showAlert("Error", message: error.description, baseViewController: self)
            })
            .addDisposableTo(disposeBag)
    }
}

private extension MKMapView {
    var rx_updateCoordinate: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: self) { mapView, coordinate in
            let span = MKCoordinateSpanMake(0.01, 0.01)
            mapView.region = MKCoordinateRegionMake(coordinate, span)
            mapView.centerCoordinate = coordinate
        }.asObserver()
    }
}

private extension UILabel {
    var rx_locationText: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: self) { label, coordinate in
            label.text = "lat: \(coordinate.latitude), lng: \(coordinate.longitude)"
        }.asObserver()
    }
}
