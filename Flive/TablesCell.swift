//
//  TablesCell.swift
//  Flive
//
//  Created by mac for ios on 3/12/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class TablesCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var ArrowImg: UIImageView!
    @IBAction func SeeMorePress(_ sender: UIButton) {
    }
    @IBOutlet weak var TablesThumbImg: UIImageView!
    @IBOutlet weak var TablesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
