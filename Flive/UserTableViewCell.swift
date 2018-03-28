//
//  UserTableViewCell.swift
//  Flive
//
//  Created by mac for ios on 3/19/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var upcomingDayslbl: UILabel!
    @IBOutlet weak var availableworkoutLbl: UILabel!
    @IBOutlet weak var availWorkoutImg: UIImageView!
    @IBAction func seemoreAvail(_ sender: Any) {
    }
    @IBOutlet weak var seemorbtn: UIButton!
    @IBOutlet weak var nextIcon: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
