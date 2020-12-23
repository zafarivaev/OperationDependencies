//
//  AppDelegate.swift
//  OperationDependencies
//
//  Created by Zafar on 10/21/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = PhotosViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

