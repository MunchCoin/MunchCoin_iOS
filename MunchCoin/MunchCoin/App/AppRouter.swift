//
//  AppRouter.swift
//  MunchCoin
//
//  Created by Developer on 1/18/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import Foundation
import UIKit

class AppRouter: Router {
    
    var window: UIWindow?
    
    public init(scene: UIWindowScene) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = EateryViewController()
        self.window?.makeKeyAndVisible()
        self.window?.windowScene = scene
    }
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        
               
               
    }
    
    func dismiss(animated: Bool) {
        
    }
    
    
}
