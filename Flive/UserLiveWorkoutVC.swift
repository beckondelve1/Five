//
//  UserLiveWorkoutVC.swift
//  Flive
//
//  Created by iosteam on 3/27/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class UserLiveWorkoutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK:- Tab Menu
    @IBAction func handleHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    @IBAction func handleNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "notificationVC") as! notificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func handleProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func handleMenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menuCataVC") as! menuCataVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
   

}
