//
//  Eatery.swift
//  MunchCoin
//
//  Created by Developer on 10/30/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Eatery {
    var name: String!
    var address: String!
    var category: DocumentReference!
    var location: GeoPoint!
    var verificationDate: String!
    var categoryString: String!
    var distance: String?
    var id: String!
    var categoryID: String!
}
