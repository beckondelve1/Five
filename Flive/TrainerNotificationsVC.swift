//
//  TrainerNotificationsVC.swift
//  Flive
//
//  Created by mac for ios on 3/28/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class TrainerNotificationsVC: UIViewController {
    
    @IBAction func handleHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleMenu
        (_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuTrainerVC") as! MenuTrainerVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleCreateNewWorkout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewWorkoutVC") as! CreateNewWorkoutVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleTrainerProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerProfileVC") as! TrainerProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
