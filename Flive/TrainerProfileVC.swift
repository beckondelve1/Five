//
//  TrainerProfileVC.swift
//  Flive
//
//  Created by mac for ios on 3/19/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class TrainerProfileVC: UIViewController {

    @IBOutlet weak var trainerProfileImg: UIImageView!
    @IBOutlet weak var trainerName: UILabel!
    
    @IBOutlet weak var followbtn: UIButton!
    @IBAction func followaction(_ sender: Any) {
    }
    @IBAction func switchToProfileBTN(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        followbtn.layer.cornerRadius = 7
        followbtn.layer.borderWidth = 0.7
        followbtn.layer.borderColor = UIColor.white.cgColor
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
