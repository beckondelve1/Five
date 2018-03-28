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
