//
//  LPMainVC.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit

class LPMainVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var favoritesBtn: UIButton!
    @IBOutlet private var searchBtn: UIButton!
    @IBOutlet private var settingsBtn: UIButton!
    
    @IBOutlet private var collectionView: UICollectionView!
    
}


extension LPMainVC: UICollectionViewDelegate {
    
}

extension LPMainVC: UICollectionViewDelegateFlowLayout {
    
}
