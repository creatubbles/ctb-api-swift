//
//  AppDelegate.swift
//  CreatubblesAPIClientDemo
//
//  Created by Benjamin Hendricks on 4/28/17.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
   
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == OAuthExampleConstants.redirectURIScheme {
            if let viewController = window?.rootViewController as? ViewController {
                viewController.handleOpenUrl(url: url)
            }
        }
        return true
    }

}

