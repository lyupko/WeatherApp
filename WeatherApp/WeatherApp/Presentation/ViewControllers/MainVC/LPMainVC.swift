//
//  LPMainVC.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit
import CoreData

class LPMainVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var favoritesBtn: UIButton!
    @IBOutlet private var searchBtn: UIButton!
    @IBOutlet private var settingsBtn: UIButton!
    
    @IBOutlet private var weatherDispayView: LPWeatherDisplayView!
    
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LPWeatherManager.instance.getDefaultWeather()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(notifyFoundLocationOfDevice), name: "findLocationOfUser", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(notifyDisableLocationManager), name: "locationDisabled", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - Private methods
    
    //MARK: Notifations
    
    @objc private func notifyDisableLocationManager(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            
            let alert = UIAlertController(title: "Local service disabled", message: "", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: { alert in
                
                let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.sharedApplication().openURL(url)
                }
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func notifyFoundLocationOfDevice(notification: NSNotification) {
        LPWeatherManager.instance.getWeatherByCurrentLocation()
    }
}
