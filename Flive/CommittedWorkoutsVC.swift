//
//  CommittedWorkoutsVC.swift
//  Flive
//
//  Created by mac for ios on 3/16/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class CommittedWorkoutsVC: UIViewController{
    @IBOutlet weak var checkImg12: UIImageView!
    @IBOutlet weak var checkImg34: UIImageView!
   
    @IBOutlet weak var checkImg56: UIImageView!
    @IBOutlet weak var checkImg7: UIImageView!
    var committedWorkouts = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func one2Btn(_ sender: Any) {
        if checkImg12.image == #imageLiteral(resourceName: "checked_sel"){
            checkImg12.image = #imageLiteral(resourceName: "check")
            checkImg34.image = #imageLiteral(resourceName: "checked_sel")
             checkImg56.image = #imageLiteral(resourceName: "checked_sel")
            checkImg7.image = #imageLiteral(resourceName: "checked_sel")
            checkImg12.image = #imageLiteral(resourceName: "checked_sel")
            committedWorkouts = "1-2"
        }else{
            checkImg12.image = #imageLiteral(resourceName: "checked_sel")
            committedWorkouts = ""
        }
    }
   
    @IBAction func three4Btn(_ sender: Any) {
        if checkImg34.image == #imageLiteral(resourceName: "checked_sel"){
            checkImg34.image = #imageLiteral(resourceName: "check")
            checkImg56.image = #imageLiteral(resourceName: "checked_sel")
            checkImg7.image = #imageLiteral(resourceName: "checked_sel")
            checkImg12.image = #imageLiteral(resourceName: "checked_sel")
            committedWorkouts = "3-4"
        }else{
            checkImg34.image = #imageLiteral(resourceName: "checked_sel")
            committedWorkouts = ""
        }
    }
    @IBAction func five6Btn(_ sender: Any) {
        if checkImg56.image == #imageLiteral(resourceName: "checked_sel"){
        checkImg56.image = #imageLiteral(resourceName: "check")
            checkImg34.image = #imageLiteral(resourceName: "checked_sel")
            checkImg7.image = #imageLiteral(resourceName: "checked_sel")
            checkImg12.image = #imageLiteral(resourceName: "checked_sel")
            committedWorkouts = "5-6"
    }else{
        checkImg56.image = #imageLiteral(resourceName: "checked_sel")
            committedWorkouts = ""
        }
    }
    @IBAction func sevenBtn(_ sender: Any) {
        if checkImg7.image == #imageLiteral(resourceName: "checked_sel"){
            checkImg7.image = #imageLiteral(resourceName: "check")
            checkImg34.image = #imageLiteral(resourceName: "checked_sel")
            checkImg56.image = #imageLiteral(resourceName: "checked_sel")
            checkImg12.image = #imageLiteral(resourceName: "checked_sel")
            committedWorkouts = "7"
        }else{
            checkImg7.image = #imageLiteral(resourceName: "checked_sel")
            committedWorkouts = ""
        }
    }

    @IBAction func back2preferredworkout(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func go2workoutLength(_ sender: Any) {
        SVProgressHUD.show()
        if committedWorkouts == ""{
            print("Please select category")
        }
        else{
            let ref = Database.database().reference()
            if let userUid = Auth.auth().currentUser?.uid{
                ref.child(userUid).updateChildValues(["committedWorkouts": committedWorkouts], withCompletionBlock: { (err, refr) in
                    if err != nil{
                        print(err?.localizedDescription ?? "")
                        return
                    }
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "WorkoutLengthVC") as! WorkoutLengthVC
                     SVProgressHUD.dismiss()
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true, completion: nil)
                })
            }
        }
    }

}
