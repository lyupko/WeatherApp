//
//  LPWeatherCVCell.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit

class LPWeatherCVCell: UICollectionViewCell {
    
    @IBOutlet private weak var cityTitleLbl: UILabel!
    @IBOutlet private weak var temperatureTitleLbl: UILabel!
    @IBOutlet private weak var feelingTitleLbl: UILabel!
    @IBOutlet private weak var tempLimitTitleLbl: UILabel!
    
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
    }
    
}
