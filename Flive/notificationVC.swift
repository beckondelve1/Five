//
//  notificationVC.swift
//  Flive
//
//  Created by mac for ios on 3/14/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class notificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK:- Tab Menu
    @IBAction func handleHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleMenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menuCataVC") as! menuCataVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleLiveWorkout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserLiveWorkoutVC") as! UserLiveWorkoutVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }

}
