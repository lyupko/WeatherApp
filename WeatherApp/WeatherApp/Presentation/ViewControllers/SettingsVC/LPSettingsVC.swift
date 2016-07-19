//
//  LPSettingsVC.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit

class LPSettingsVC: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Constructors
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
    }
    
    // MARK: - Methods of class
    class func start() {
        
    }
    
    // MARK: - Methods of instance
    
    // MARK: - Actions
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Private methods
    
}
