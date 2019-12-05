//
//  MapViewController.swift
//  MunchCoin
//
//  Created by Developer on 12/1/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore

class MapViewController: UIViewController {
    
    var mapView: MKMapView = MKMapView()
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocation?
    var searchButton: UIButton = UIButton()
    var eateries: [Eatery] = []
    var userLocationButton: UIButton = UIButton()
    var network = Network.shared
    var queriedLocationIDs: [String:CLLocation] = [:]
    var currentRegion: MKCoordinateRegion?
    
    override func viewWillAppear(_ animated: Bool) {
        print("View")
        
        if let userLocation = userLocation {
            mapView.setCenter(userLocation.coordinate, animated: true)
            print("View")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            authorizeLocationManager()
            break
        case .denied, .notDetermined, .restricted:
            locationManager.requestWhenInUseAuthorization()
            break
        @unknown default:
            fatalError()
        }
        mapView.delegate = self
        
        
        configureViews()
        
    }
    
    func configureViews() {
        
        mapView.mapType = .mutedStandard
        mapView.isPitchEnabled = false
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        // 40.730610, -73.935242.
        
        //        let initialLocation = CLLocation(latitude: 40.730610, longitude: -73.935242)
        //        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: <#T##CLLocationDegrees#>, longitudeDelta: <#T##CLLocationDegrees#>)
        //        let coordinateRegion = MKCoordinateRegion(center: <#T##CLLocationCoordinate2D#>, span: <#T##MKCoordinateSpan#>)
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(userLocationButton)
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false
        userLocationButton.heightAnchor.constraint(equalToConstant: 49).isActive = true
        userLocationButton.widthAnchor.constraint(equalToConstant: 49).isActive = true
        userLocationButton.layer.cornerRadius = 49 / 2
        let locationImage = UIImage(systemName: "location.fill")
        userLocationButton.setImage(locationImage, for: .normal)
        userLocationButton.setTitle(nil, for: .normal)
        userLocationButton.tintColor = Branding.Color.darkBlue
        userLocationButton.backgroundColor = .systemBackground
        userLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        userLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        userLocationButton.addTarget(self, action: #selector(setUserLocation), for: .touchUpInside)
        view.bringSubviewToFront(userLocationButton)
        
        searchButton.setTitle("SEARCH AREA", for: .normal)
        searchButton.setTitleColor(Branding.Color.black, for: .normal)
        searchButton.backgroundColor = Branding.Color.yellow
        searchButton.titleLabel?.font = UIFont(name: Branding.Font.berlinDemi, size: 17)
        searchButton.addTarget(self, action: #selector(updateMap), for: .touchUpInside)
        
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.heightAnchor.constraint(equalToConstant: 49).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 147).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        searchButton.layer.cornerRadius = 8
        view.bringSubviewToFront(searchButton)
        searchButton.isHidden = true

        
        
        
    }
    
    @objc func setUserLocation() {
        
        guard let coordinates = userLocation?.coordinate else {
            return
        }
        
        mapView.setCenter(coordinates, animated: true)
        
    }
    
    func authorizeLocationManager(){
        locationManager.startUpdatingLocation()
    }
    
    func createAnnotation(from items: [Eatery]) -> [MKPointAnnotation] {
        return items.map {
            item in
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.location.latitude, longitude: item.location.longitude)
            annotation.title = item.name
            annotation.subtitle = item.categoryString
            return annotation
        }
    }
    
    func add(_ location: Eatery) {
        eateries.append(location)
        let annotations = createAnnotation(from: [location])
        mapView.addAnnotations(annotations)
        searchButton.isHidden = true

    }
    
    @objc func updateMap() {
        let region = mapView.region
        eateries = []
        mapView.removeAnnotations(mapView.annotations)
        print(1)
        network.getLocations(within: region, results: {
            [weak self]
            documentID, location in
            print(2)
            guard let documentID = documentID else {
                return
            }
            
            self?.network.returnEatery(from: documentID) {
                eatery in
                print(3)
                self?.add(eatery)
                
            }
        })
    }
}
