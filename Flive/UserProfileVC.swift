//
//  UserProfileVC.swift
//  Flive
//
//  Created by iosteam on 3/26/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class UserProfileVC: UIViewController {
    
    
    let myimages = ["cat_1","cat_2","cat_5","cat_6",]
    @IBOutlet weak var collectionview1: UICollectionView!
    
    @IBOutlet weak var collectionview2: UICollectionView!
    @IBOutlet weak var userprofileName: UILabel!
    @IBOutlet weak var userprofileImg: UIImageView!
    
    let call = Functions()
    var arrTrainerUID = [String]()
    var arrTrainerDetail = [TrainerDetail]()
    var availableWorkouts = [Workouts]()
    var comingSoonWorkouts = [Workouts]()
    var dicComingSoonWorkouts = [String:Workouts]()
    var dicAvailableWorkouts = [String:Workouts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.fetchDetailsOfUser()
        fetchAllWorkouts()
      userprofileImg.layer.cornerRadius = userprofileImg.frame.height/2
        userprofileImg.clipsToBounds = true
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
    
    @IBAction func handleNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "notificationVC") as! notificationVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func fetchDetailsOfUser() {
        SVProgressHUD.show()
        if let uid = Auth.auth().currentUser?.uid{
            
            let ref = Database.database().reference().child("user")
            ref.child(uid).observe(.value, with: { (snap) in
                let snapshot = snap.value as! [String:Any]
                self.userprofileName.text = snapshot["name"]! as? String
                let imageUrl = snapshot["imageUrl"]! as? String
                let imUrl = URL(string: imageUrl!)
                let imData = try? Data(contentsOf: imUrl!)
                self.userprofileImg.image = UIImage(data: imData!)
                //self.trainerProfileImg.image =
                SVProgressHUD.dismiss()
            }, withCancel: nil)
        }
    }
  
    func fetchAllWorkouts(){
        SVProgressHUD.show()
        let _ = Database.database().reference().child("trainer_workouts").observe(.childAdded) { (snap) in
            let dic :Dictionary = snap.value as! [String:Any]
            let workout = Workouts()
            workout.setValuesForKeys(dic)
            let timestampNow = round(NSDate().timeIntervalSince1970)
            if workout.workout_time!.doubleValue > timestampNow{
                self.dicComingSoonWorkouts[workout.workout_category!] = workout
                
            }
            else{
                self.dicAvailableWorkouts[workout.workout_category!] = workout
            }
            
            self.availableWorkouts = Array(self.dicAvailableWorkouts.values)
            self.comingSoonWorkouts = Array(self.dicComingSoonWorkouts.values)
            self.availableWorkouts.sort(by: { (message1, message2) -> Bool in
                return  message1.workout_time!.intValue > message2.workout_time!.intValue
            })
            self.comingSoonWorkouts.sort(by: { (message1, message2) -> Bool in
                return  message1.workout_time!.intValue > message2.workout_time!.intValue
            })
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.reloadTable), userInfo: nil, repeats: false)
            
            
        }
        
    }
    var timer : Timer?
    @objc func reloadTable() {
        self.collectionview1.reloadData()
        self.collectionview2.reloadData()
        SVProgressHUD.dismiss()
    }

}


extension UserProfileVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableWorkouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionview1{
            let workout = availableWorkouts[indexPath.row]
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "UserprofileCell1", for: indexPath) as! UserprofileCell1
            cell1.currentworkoutImg.sd_setImage(with: URL(string: workout.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
            
            return cell1
        }else{
            let workout = availableWorkouts[indexPath.row]
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProfileCell2", for: indexPath) as! UserProfileCell2
            cell1.completedworkouts.sd_setImage(with: URL(string: workout.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
            
            return cell1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionview1{
            
            let itemperrow:CGFloat = 2
            
            let itemWidth = collectionView.bounds.width/itemperrow
            let itemHeight = collectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight)
            
        }else{
            
            let itemWidth = (collectionView.bounds.width/2  - 10 )
            let itemHeight = (collectionView.bounds.width / 3)
            return CGSize(width: itemWidth, height: itemHeight)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionview1 {
            return 2
        }else{
            return 0
        }
    }
 
  
   
}
