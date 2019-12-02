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

class Network {
    
    static let shared: Network = Network()
    private var db: Firestore!
    private var storage: Storage!
    private var references: [String: CollectionReference]!
    
    private init(){
        db = Firestore.firestore()
        storage = Storage.storage()
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
                let data = document.data()

                return to(data)
            }
        
            completion(items)
        }
    }
}
