//
//  LandingVCCell2.swift
//  Flive
//
//  Created by mac for ios on 3/12/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class LandingVCCell2: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var scrolledimage: UIImageView!
    @IBOutlet weak var label1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.cornerRadius = view.frame.height/2
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        
    }
}
