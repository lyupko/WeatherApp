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
    
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            let nibName = UINib(nibName: String(LPWeatherCVCell), bundle:nil)
            collectionView.registerNib(nibName, forCellWithReuseIdentifier: String(LPWeatherCVCell))
        }
    }

    var blockOperations: [NSBlockOperation] = []

    deinit {
        // Cancel all block operations when VC deallocates
        for operation: NSBlockOperation in blockOperations {
            operation.cancel()
        }
        
        blockOperations.removeAll(keepCapacity: false)
    }
    
    private lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fRequest = LPMainVC.fetchRequest()
        let aFetchedResultsController: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fRequest, managedObjectContext: LPDBManager.sharedInstance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        aFetchedResultsController.delegate = self
        
        var error: NSError? = nil
        
        try! aFetchedResultsController.performFetch()
        
        return aFetchedResultsController
    }()
    
    class func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName:String(Location))
        let sortDescriptor = NSSortDescriptor(key: "name", ascending:true)
        let predicate = NSPredicate(format: "type == %i", 0)
        
        // Set the predicate on the fetch request
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
}


extension LPMainVC: UICollectionViewDelegate {
    
}

extension LPMainVC: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(String(LPWeatherCVCell), forIndexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return view.frame.size
    }
    
}

extension LPMainVC: UICollectionViewDelegateFlowLayout {
    
}

extension LPMainVC: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        blockOperations.removeAll(keepCapacity: false)
    }
    
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject,
                                    atIndexPath indexPath: NSIndexPath?,
                                                forChangeType type: NSFetchedResultsChangeType,
                                                              newIndexPath: NSIndexPath?) {
        
        if type == NSFetchedResultsChangeType.Insert {
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertItemsAtIndexPaths([newIndexPath!])
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.Update {
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadItemsAtIndexPaths([indexPath!])
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.Delete {
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteItemsAtIndexPaths([indexPath!])
                    }
                    })
            )
        }
    }
    
    func controller(controller: NSFetchedResultsController,
                    didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                                     atIndex sectionIndex: Int,
                                             forChangeType type: NSFetchedResultsChangeType) {
        
        if type == NSFetchedResultsChangeType.Insert {
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertSections(NSIndexSet(index: sectionIndex))
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.Update {
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadSections(NSIndexSet(index: sectionIndex))
                    }
                    })
            )
        }
        else if type == NSFetchedResultsChangeType.Delete {
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteSections(NSIndexSet(index: sectionIndex))
                    }
                    })
            )
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView!.performBatchUpdates({ () -> Void in
            for operation: NSBlockOperation in self.blockOperations {
                operation.start()
            }
            }, completion: { (finished) -> Void in
                self.blockOperations.removeAll(keepCapacity: false)
        })
    }
}
