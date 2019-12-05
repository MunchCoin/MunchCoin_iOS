//
//  MapViewControllerLocationDelegate.swift
//  MunchCoin
//
//  Created by Developer on 12/1/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import CoreLocation


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizeLocationManager()
    }
}
