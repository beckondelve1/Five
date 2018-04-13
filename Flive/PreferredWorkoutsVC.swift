//
//  PreferredWorkoutsVC.swift
//  Flive
//
//  Created by mac for ios on 3/16/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PreferredWorkoutsVC: UIViewController{
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var gymImg: UIImageView!
    @IBOutlet weak var equipmentImg: UIImageView!
    @IBOutlet weak var bodyweightImg: UIImageView!
    @IBOutlet weak var officeImg: UIImageView!
    var preferredWorkouts = ""
    var call = Functions()
    @IBAction func back2Complevel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func gymBtn(_ sender: Any) {
        if gymImg.image == #imageLiteral(resourceName: "checked_sel") {
            gymImg.image = #imageLiteral(resourceName: "check")
             equipmentImg.image = #imageLiteral(resourceName: "checked_sel")
             bodyweightImg.image = #imageLiteral(resourceName: "checked_sel")
            officeImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = "Gym"
        }else{
            gymImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = ""
        }
    }
 
    @IBAction func equipmentBtn(_ sender: Any) {
        if equipmentImg.image == #imageLiteral(resourceName: "checked_sel") {
            equipmentImg.image = #imageLiteral(resourceName: "check")
            bodyweightImg.image = #imageLiteral(resourceName: "checked_sel")
            officeImg.image = #imageLiteral(resourceName: "checked_sel")
            gymImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = "Home"
        }else{
            equipmentImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = ""
        }
    }

    @IBAction func BodyweightBtn(_ sender: Any) {
        if bodyweightImg.image == #imageLiteral(resourceName: "checked_sel") {
            bodyweightImg.image = #imageLiteral(resourceName: "check")
            equipmentImg.image = #imageLiteral(resourceName: "checked_sel")
            officeImg.image = #imageLiteral(resourceName: "checked_sel")
            gymImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = "BodyWeight"
        }else{
            bodyweightImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = ""
        }
    }
    @IBAction func officeBtn(_ sender: Any) {
        if officeImg.image == #imageLiteral(resourceName: "checked_sel") {
            officeImg.image = #imageLiteral(resourceName: "check")
            equipmentImg.image = #imageLiteral(resourceName: "checked_sel")
            bodyweightImg.image = #imageLiteral(resourceName: "checked_sel")
            gymImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = "Office"
        }else{
            officeImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = ""
        }
    }
    @IBAction func go2committedWorkout(_ sender: Any) {
         SVProgressHUD.show()
        if preferredWorkouts == ""{
            call.showAlertWithoutAction(title: "Error", message: "Select Preferred Workouts!", view: self)
            SVProgressHUD.dismiss()
        }
        else{
           
            let ref = Database.database().reference().child("user")
            if let userUid = Auth.auth().currentUser?.uid{
                ref.child(userUid).updateChildValues(["preferredWorkouts": preferredWorkouts], withCompletionBlock: { (err, refr) in
                    if err != nil{
                        print(err?.localizedDescription ?? "")
                        return
                    }
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommittedWorkoutsVC") as! CommittedWorkoutsVC
                     SVProgressHUD.dismiss()
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true, completion: nil)
                })
            }
        }
    }
}
