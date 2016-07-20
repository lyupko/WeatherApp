//
//  LPFavoritesVC.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit
import CoreData

class LPFavoritesVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRectZero)
        }
    }
    
    // MARK: - Private Properties
    
    private lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fRequest = LPFavoritesVC.fetchRequest()
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fRequest, managedObjectContext: LPDBManager.sharedInstance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        aFetchedResultsController.delegate = self
        
        var error: NSError? = nil
        
        try! aFetchedResultsController.performFetch()
        
        return aFetchedResultsController
    }()
    
    // MARK: - Constructors
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
    }
    
    // MARK: - Methods of class
    
    class func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: String(Location))
        let sortDescriptor = NSSortDescriptor(key: "city", ascending:true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }

    
    // MARK: - Actions
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func deleteLocation(atIndexPath indexPath: NSIndexPath) {
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Location
        Location.deleteLocation(item)
    }
}

extension LPFavoritesVC: NSFetchedResultsControllerDelegate {
    
    func controller(
        controller: NSFetchedResultsController,
        didChangeObject anObject: AnyObject,
                        atIndexPath indexPath: NSIndexPath?,
                                    forChangeType type: NSFetchedResultsChangeType,
                                                  newIndexPath: NSIndexPath?) {
        
        switch type {
        case NSFetchedResultsChangeType.Insert:
            // Note that for Insert, we insert a row at the __newIndexPath__
            if let insertIndexPath = newIndexPath {
                self.tableView.insertRowsAtIndexPaths([insertIndexPath], withRowAnimation: UITableViewRowAnimation.None)
            }
        case NSFetchedResultsChangeType.Delete:
            // Note that for Delete, we delete the row at __indexPath__
            if let deleteIndexPath = indexPath {
                self.tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: UITableViewRowAnimation.None)
            }
        case NSFetchedResultsChangeType.Update:
            // Note that for Update, we update the row at __indexPath__
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.None)
        case NSFetchedResultsChangeType.Move:
            // Note that for Move, we delete the row at __indexPath__
            if let deleteIndexPath = indexPath {
                self.tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: UITableViewRowAnimation.None)
            }
            
            // Note that for Move, we insert a row at the __newIndexPath__
            if let insertIndexPath = newIndexPath {
                self.tableView.insertRowsAtIndexPaths([insertIndexPath], withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }
    
    func controller(
        controller: NSFetchedResultsController,
        didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                         atIndex sectionIndex: Int,
                                 forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Insert:
            let sectionIndexSet = NSIndexSet(index: sectionIndex)
            self.tableView.insertSections(sectionIndexSet, withRowAnimation: UITableViewRowAnimation.None)
        case .Delete:
            let sectionIndexSet = NSIndexSet(index: sectionIndex)
            self.tableView.deleteSections(sectionIndexSet, withRowAnimation: UITableViewRowAnimation.None)
        default: break
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
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
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(LPLocationTVCell)) as! LPLocationTVCell
        
        let item  = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Location
        
        cell.update(item.city)
        
        return cell
    }
    
}
