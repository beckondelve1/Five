//
//  WorkoutLengthVC.swift
//  Flive
//
//  Created by mac for ios on 3/16/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class WorkoutLengthVC: UIViewController{
    @IBOutlet weak var img510: UIImageView!

    @IBOutlet weak var img1015: UIImageView!
    @IBOutlet weak var img1520: UIImageView!
    @IBOutlet weak var img2025: UIImageView!
    @IBOutlet weak var img2530: UIImageView!
    var workoutLength = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func length510Btn(_ sender: Any) {
        if img510.image == #imageLiteral(resourceName: "checked_sel"){
            img510.image = #imageLiteral(resourceName: "check")
            img1015.image = #imageLiteral(resourceName: "checked_sel")
            img1520.image = #imageLiteral(resourceName: "checked_sel")
            img2025.image = #imageLiteral(resourceName: "checked_sel")
            img2530.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = "5-10"
        }else{
            img510.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = ""
        }
    }
    
    @IBAction func length1015btn(_ sender: Any) {
        if img1015.image == #imageLiteral(resourceName: "checked_sel"){
            img1015.image = #imageLiteral(resourceName: "check")
            img510.image = #imageLiteral(resourceName: "checked_sel")
            img1520.image = #imageLiteral(resourceName: "checked_sel")
            img2025.image = #imageLiteral(resourceName: "checked_sel")
            img2530.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = "10-15"
        }else{
            img1015.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = ""
        }
    }
    @IBAction func length1520(_ sender: Any) {
        if img1520.image == #imageLiteral(resourceName: "checked_sel"){
            img1520.image = #imageLiteral(resourceName: "check")
            img510.image = #imageLiteral(resourceName: "checked_sel")
            img1015.image = #imageLiteral(resourceName: "checked_sel")
            img2025.image = #imageLiteral(resourceName: "checked_sel")
            img2530.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = "15-20"
        }else{
            img1520.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = ""
        }
    }
    
    @IBAction func length2025btn(_ sender: Any) {
        if img2025.image == #imageLiteral(resourceName: "checked_sel"){
            img2025.image = #imageLiteral(resourceName: "check")
            img510.image = #imageLiteral(resourceName: "checked_sel")
            img1015.image = #imageLiteral(resourceName: "checked_sel")
            img1520.image = #imageLiteral(resourceName: "checked_sel")
            img2530.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = "20-25"
        }else{
            img2025.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = ""
        }
    }
    @IBAction func length2530btn(_ sender: Any) {
        if img2530.image == #imageLiteral(resourceName: "checked_sel"){
            img2530.image = #imageLiteral(resourceName: "check")
            img510.image = #imageLiteral(resourceName: "checked_sel")
            img1015.image = #imageLiteral(resourceName: "checked_sel")
            img1520.image = #imageLiteral(resourceName: "checked_sel")
            img2025.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = "25-30"
        }else{
            img2530.image = #imageLiteral(resourceName: "checked_sel")
            workoutLength = ""
        }
    }
    @IBAction func handleNext(_ sender: Any) {
        SVProgressHUD.show()
        if workoutLength == ""{
            print("Please select category")
        }
        else{
            let ref = Database.database().reference()
            if let userUid = Auth.auth().currentUser?.uid{
                ref.child(userUid).updateChildValues(["workoutLength": workoutLength], withCompletionBlock: { (err, refr) in
                    if err != nil{
                        print(err?.localizedDescription ?? "")
                        return
                    }
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserSubscriptionVC") as! UserSubscriptionVC
                     SVProgressHUD.dismiss()
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true, completion: nil)
                })
            }
        }
    }
    @IBAction func back2committedwork(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
