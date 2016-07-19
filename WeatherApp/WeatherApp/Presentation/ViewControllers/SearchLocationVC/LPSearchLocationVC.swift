//
//  LPSearchLocationVC.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit
import SVProgressHUD

class LPSearchLocationVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRectZero)
        }
    }
    
    @IBOutlet private weak var tableViewBottom: NSLayoutConstraint!
    
    // MARK: - Private Properties
    private var searchBar = UISearchBar()
    
    private var locationsList = []
    
    // MARK: - Constructors
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSearchBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.resignFirstResponder()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        
        let keyboardSize = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        tableViewBottom.constant = keyboardSize?.height ?? 0
        
        UIView.animateWithDuration(keyboardAnimationTime(notification),
                                   delay: 0,
                                   options: .CurveLinear,
                                   animations: {
                                    self.view.layoutIfNeeded()
                                    
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        tableViewBottom.constant = 0
        UIView.animateWithDuration(keyboardAnimationTime(notification),
                                   delay: 0,
                                   options: .CurveLinear,
                                   animations: {
                                    self.view.layoutIfNeeded()
                                    
            }, completion: nil)
    }
    
    func keyboardAnimationTime(notification: NSNotification) -> NSTimeInterval {
        var duration: NSTimeInterval = 0.0;
        notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.getValue(&duration)
        return duration
    }
    
    // MARK: - Actions
    
    func cancelBtnPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func prepareSearchBar() {
        searchBar.sizeToFit()
        
        searchBar.delegate = self
        searchBar.placeholder = "Type City or ZIP code"
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelBtnPressed))
        navigationItem.rightBarButtonItem = cancelBtn
        navigationItem.titleView = searchBar
    }
    
    @objc private func searchLocation(text: String) {
        SVProgressHUD.show()
    }
    
    private func addToFavorite() {
        cancelBtnPressed()
    }
}

extension LPSearchLocationVC: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        SVProgressHUD.dismiss()
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        self.performSelector(#selector(searchLocation), withObject: searchText, afterDelay: 0.5)
    }
}

extension LPSearchLocationVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        addToFavorite()
    }
}

extension LPSearchLocationVC: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 6//locationsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(LPLocationTVCell))
        return cell!
    }
    
}
