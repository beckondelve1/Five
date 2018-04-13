//
//  UserCollectionViewCell2.swift
//  Flive
//
//  Created by mac for ios on 3/19/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class UserCollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet weak var trendingworkoutImg: UIImageView!
    @IBOutlet weak var trendingworkoutLBL: UILabel!
    @IBOutlet weak var view1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view1.layer.cornerRadius = view1.frame.height/2
        view1.clipsToBounds = true
        view1.layer.borderWidth = 2
        view1.layer.borderColor = UIColor.lightGray.cgColor
        
    }

}
