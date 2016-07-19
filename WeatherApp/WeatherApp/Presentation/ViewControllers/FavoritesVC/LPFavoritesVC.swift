//
//  LPFavoritesVC.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit

class LPFavoritesVC: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRectZero)
        }
    }
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Constructors
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
    }
    
    // MARK: - Methods of instance
    
    // MARK: - Actions
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func deleteLocation(atIndexPath indexPath: NSIndexPath) {
        
    }
}

extension LPFavoritesVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard editingStyle == .Delete else {
            return
        }
        
        deleteLocation(atIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

extension LPFavoritesVC: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6//locationsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(LPLocationTVCell))
        return cell!
    }
    
}
