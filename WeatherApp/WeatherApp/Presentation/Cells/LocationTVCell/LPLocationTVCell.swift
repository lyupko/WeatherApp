//
//  LPLocationTVCell.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import UIKit

class LPLocationTVCell: UITableViewCell {
    
    @IBOutlet private weak var titleLbl: UILabel!
    
    override func prepareForReuse() {
        titleLbl.text = ""
    }
    
    func update(title: String?) {
        titleLbl.text = title ?? ""
    }
}