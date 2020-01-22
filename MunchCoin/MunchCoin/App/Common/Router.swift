//
//  Router.swift
//  MunchCoin
//
//  Created by Developer on 1/18/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import Foundation
import UIKit

public protocol Router: class {
    func present(_ viewController: UIViewController, animated: Bool)
    
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?)
    
    func dismiss(animated: Bool)
}

extension Router {
    public func present(_ viewController: UIViewController, animated: Bool){
        present(viewController, animated: animated, onDismissed: nil)
    }
}
