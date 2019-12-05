//
//  Network.swift
//  MunchCoin
//
//  Created by Developer on 11/27/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Geofirestore
import MapKit

class Network {
    
    static let shared: Network = Network()
    private var db: Firestore!
    private var storage: Storage!
    private var references: [String: CollectionReference]!
    private var geoFirestore: GeoFirestore!
    
    private init(){
        db = Firestore.firestore()
        storage = Storage.storage()
        let geoFirestoreRef = db.collection("Eateries")
        geoFirestore = GeoFirestore(collectionRef: geoFirestoreRef)
    }
    
    func get<T>(_ type: String, query: (field: String, value: Any)? = nil, converted to: @escaping ([String:Any]) -> T, completion: @escaping ([T]?) -> ()) {
        let reference = query == nil ? db.collection(type): db.collection(type).whereField(query!.field, isEqualTo: query!.value)
        
        reference.getDocuments {
            snapshot, error in
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            let items: [T] = snapshot.documents.map {
                document in
                var data = document.data()
                data["id"] = document.documentID
                return to(data)
            }
            
            completion(items)
        }
        
    }
    
    func getLocations(within region: MKCoordinateRegion, results: @escaping (String?, CLLocation?) -> (), completion: (() -> ())? = nil) {
        
        let regionQuery = geoFirestore.query(inRegion: region)
        let queryHandle = regionQuery.observe(.documentEntered) {
            documentID, location in
           
            results(documentID, location)
        }
        
        regionQuery.observeReady {
            completion?()
        }
    }
    
    func returnEatery(from id: String, converted to: @escaping (Eatery) -> ()) {
        
        
        db.collection("Eateries").whereField(FieldPath.documentID(), isEqualTo: id).getDocuments {
            snapshot, error in
            
            guard let snapshot = snapshot else {
                return
            }
            
            guard let document = snapshot.documents.first else {
                return
            }
            
            let data = document.data()
            var eatery = Eatery()
            eatery.name = (data["name"] as! String)
            eatery.address = (data["address"] as! String)
            eatery.verificationDate = (data["verificationDate"] as! String)
            eatery.category = (data["category"] as! DocumentReference)
            eatery.location = (data["location"] as! GeoPoint)
            to(eatery)
        }
    }
    
    func set(location: GeoPoint, for document: String) {
        geoFirestore.setLocation(geopoint: location, forDocumentWithID: document) {
            error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("saved")
            }
        }
    }
}
