//
//  Extensions.swift
//  MunchCoin
//
//  Created by Developer on 11/29/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

extension UILabel {
    func setText(from ref: DocumentReference, with setup: @escaping ([String:Any]) -> NSAttributedString) {
        ref.getDocument {
            [weak self]
            snapshot, error in
            
            guard let snapshot = snapshot, snapshot.exists else {
                return
            }
            
            guard let data = snapshot.data() else {
                return
            }
            
            let text = setup(data)
            
            self?.attributedText = text
            self?.setNeedsDisplay()
        }
    }
}
