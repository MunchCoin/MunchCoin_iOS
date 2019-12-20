//
//  Receipt.swift
//  MunchCoin
//
//  Created by Developer on 12/18/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

protocol Receipt {
    var locationID: String! {get set}
    var date: Date! {get set}
    var imageID: String! {get}
    var amount: Double! {get set}
}

struct ReceiptSubmission: Receipt {
    var locationID: String!
    var date: Date!
    var imageID: String! {
        return "\(self.walletAddress.hashValue)\(self.image.hashValue)\(self.date.hashValue)"
        }
    var amount: Double!
    
    var image: Data!
    var walletAddress: String!
    var categoryID: String!
}

enum ReceiptSubmissionStatus: String {
    typealias RawValue = String
    
    case rejcted, approved, review
}

struct ReceiptSubmissionItem: Receipt {
    var locationID: String!
    var date: Date!
    var imageID: String!
    var amount: Double!
    
    var status: ReceiptSubmissionStatus!
    var submissionDate: Date!
    var dateReviewed: Date?
    var note: String?
    var munchCoinAmount: Double?
}

