//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/18/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit

import SVProgressHUD
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NetworkActivityIndicatorManager.sharedManager.isEnabled = true
        
        customizeUI()
        
        if didFinishLaunchingOnce() {
            Location.createDefaultLocation()
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
    
    // MARK: - Private methods
    
    private func customizeUI() {
        SVProgressHUD.setForegroundColor(UIColor(red: 25.0/255.0, green: 118.0/255.0, blue: 210.0/255.0, alpha: 1))
    }
    
    private func didFinishLaunchingOnce() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.stringForKey("hasAppBeenLaunchedBefore") != nil) {
            return false
        } else {
            defaults.setBool(true, forKey: "hasAppBeenLaunchedBefore")
            return true
        }
    }
}

