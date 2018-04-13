//
//  TrainerCollectionViewCell2.swift
//  Flive
//
//  Created by iosteam on 3/26/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class TrainerCollectionViewCell2: UICollectionViewCell {
    @IBOutlet weak var cell2Img: UIImageView!
    
    @IBOutlet weak var cell2Lbl: UILabel!
    @IBOutlet weak var view1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view1.layer.cornerRadius = view1.frame.height/2
        view1.clipsToBounds = true
        view1.layer.borderWidth = 2
        view1.layer.borderColor = UIColor.lightGray.cgColor
        
    }
}
