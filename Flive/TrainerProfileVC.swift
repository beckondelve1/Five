//
//  TrainerProfileVC.swift
//  Flive
//
//  Created by mac for ios on 3/19/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class TrainerProfileVC: UIViewController {

    @IBOutlet weak var trainerProfileImg: UIImageView!
    @IBOutlet weak var trainerName: UILabel!
    
    @IBOutlet weak var lblFollowerCount: UILabel!
    @IBOutlet weak var trainerBio: UITextView!
    @IBOutlet weak var followbtn: UIButton!
    @IBOutlet weak var lblVideoCount: UILabel!
    var bio:String?
    var name:String?
    var imageUrl:String?
    var viewer  : Bool = false
    var trainerUID : String?
    var videoCounter : UInt?
    var arrTrainer = [TrainerDetail]()
    @IBAction func followaction(_ sender: Any) {
        if viewer{
            if let uid = Auth.auth().currentUser?.uid{
                let ref = Database.database().reference()
                ref.child("trainer_followers").child(trainerUID!).updateChildValues([uid:"1"])
                ref.child("user_following").child(uid).updateChildValues([trainerUID!:"1"])
            }
        }
        else{
            print("edit profile")
        }
    }
    @IBAction func switchToProfileBTN(_ sender: Any) {
        
    }
    @IBAction func handleLogout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }
        catch{
            
        }
    }
    
    @IBAction func handleMenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuTrainerVC") as! MenuTrainerVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handlenotifications(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerNotificationsVC") as! TrainerNotificationsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleCreateNewWorkout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewWorkoutVC") as! CreateNewWorkoutVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleTrainerHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchFollowers()
        self.fetchDetailsOfTrainer()
        self.fetchWorkoutCount()
        //self.addActionsToLable()
        followbtn.layer.cornerRadius = 7
        followbtn.layer.borderWidth = 0.7
        followbtn.layer.borderColor = UIColor.white.cgColor
        trainerProfileImg.layer.cornerRadius = trainerProfileImg.frame.height/2
        trainerProfileImg.clipsToBounds = true
        trainerProfileImg.layer.borderWidth = 2
        trainerProfileImg.layer.borderColor = UIColor(red: 217/255, green: 255/255, blue: 0/255, alpha: 1).cgColor
        if !viewer{
            followbtn.setTitle("Edit Profile", for: .normal)
        }
    }
//    func addActionsToLable(){
//        let tapOnVideo = UITapGestureRecognizer(target: self, action: #selector(handleVideoTap))
//        lblVideoCount.isUserInteractionEnabled = true
//        lblVideoCount.addGestureRecognizer(tapOnVideo)
//        let tapOnFollowers = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTap))
//        lblFollowerCount.isUserInteractionEnabled = true
//        lblFollowerCount.addGestureRecognizer(tapOnFollowers)
//
//    }
//    @objc func handleVideoTap(){
//        print("more videos")
//    }
//    @objc func handleFollowersTap(){
//        print("getting followers")
//    }
    func fetchWorkoutCount(){
        let ref = Database.database().reference()
        if viewer{
            ref.child("trainer_releation").child(trainerUID!).observe(.value, with: { (snap) in
                self.lblVideoCount.text = String(describing: snap.childrenCount)
            })
        }
        else{
            if let uid = Auth.auth().currentUser?.uid{
                ref.child("trainer_releation").child(uid).observe(.value, with: { (snap) in
                    print(snap)
                    self.lblVideoCount.text = String(describing: snap.childrenCount)
                    
                    
                })
            }
            
        }
        
    }
    func fetchDetailsOfTrainer() {
        SVProgressHUD.show()
        if !viewer {
             trainerUID = Auth.auth().currentUser?.uid
        }
        
            let ref = Database.database().reference().child("trainer")
        ref.child(trainerUID!).observe(.value, with: { (snap) in
                if let snapshot = snap.value as? [String:Any]{
                    let trainer = TrainerDetail()
                    trainer.setValuesForKeys(snapshot)
                    self.trainerName.text = trainer.name ?? ""
                    self.arrTrainer.append(trainer)
                    self.trainerProfileImg.sd_setImage(with: URL(string: trainer.imageUrl  ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
                    self.trainerBio.text = trainer.bio  ?? ""
                }

                SVProgressHUD.dismiss()
            }, withCancel: nil)
        }
    func fetchFollowers()  {
        let ref = Database.database().reference()
        if viewer{
             ref.child("trainer_followers").child(trainerUID!).observe(.childAdded, with: { (snap) in
            print(snap)
        }, withCancel: nil)
        }
        else{
            if let uid = Auth.auth().currentUser?.uid{
                ref.child("user_following").child(uid).observe(.childAdded, with: { (snap) in
                    
                    
                }, withCancel: nil)
            }
            
        }
       
    }
    

}
