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

class UserComingSoonTVC: UITableViewCell {
    @IBOutlet weak var workoutTime: UILabel!
    @IBOutlet weak var workoutPostTime: UILabel!
    @IBOutlet weak var trainerName: UILabel!
    @IBOutlet weak var workoutDisc: UILabel!
    @IBOutlet weak var workoutImg: UIImageView!
    @IBOutlet weak var trainerProfileImg: UIImageView!
    @IBOutlet weak var btnGetProfile: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        workoutTime.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        workoutPostTime.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        trainerProfileImg.layer.cornerRadius = trainerProfileImg.frame.width/2
        trainerProfileImg.clipsToBounds = true
        
        
}
}
