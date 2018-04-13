//
//  TrainerTableViewCell1.swift
//  Flive
//
//  Created by iosteam on 3/26/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class TrainerTableViewCell1: UITableViewCell {
    @IBOutlet weak var availableWorkoutLabel: UILabel!
    
    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var availTimelbl: UILabel!
    @IBOutlet weak var availworkoutImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class TrainerComingSoonTVC: UITableViewCell {
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class TrainerWorkoutHeader: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
