//
//  MapViewControllerDelegate.swift
//  MunchCoin
//
//  Created by Developer on 12/1/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import MapKit
import Firebase

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if self.userLocation == nil {
            self.userLocation = userLocation.location
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
            currentRegion = region
            mapView.setRegion(region, animated: true)

        } else {
            let currentLocation = userLocation.location
            let distance = currentLocation?.distance(from: self.userLocation!)
            let distanceInMiles = distance!/1609.44
            
            if distanceInMiles > 1 {
                self.userLocation = currentLocation
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.title != "My Location" {
            var pinView: MKPinAnnotationView

        if let dequeuedPinView =  mapView.dequeueReusableAnnotationView(withIdentifier: "EateryPoints") as? MKPinAnnotationView {
            dequeuedPinView.annotation = annotation
            pinView = dequeuedPinView
        } else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "EateryPoints")
            pinView.canShowCallout = true
            pinView.calloutOffset = CGPoint(x: -5, y: 5)
        }
            
        return pinView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    
       
        searchButton.isHidden = false
               
    }
}
