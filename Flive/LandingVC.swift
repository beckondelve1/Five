//
//  LandingVC.swift
//  Flive
//
//  Created by mac for ios on 3/9/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class LandingVC: UIViewController {
    @IBOutlet weak var availableWorkoutTV: UITableView!
    @IBOutlet weak var trendingCV: UICollectionView!
    @IBOutlet weak var sliderCV: UICollectionView!
    let call = Functions()
    var arrTrainerUID = [String]()
    var arrTrainerDetail = [TrainerDetail]()
    var availableWorkouts = [Workouts]()
    var comingSoonWorkouts = [Workouts]()
    var dicComingSoonWorkouts = [String:Workouts]()
    var dicAvailableWorkouts = [String:Workouts]()

    @IBAction func user(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
        navigationController?.pushViewController(registerViewController, animated: true)

    }
    @IBAction func play(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
        navigationController?.pushViewController(registerViewController, animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
     self.navigationController?.isNavigationBarHidden = true
        self.autoLogin()
        self.fetchAllWorkouts()
        self.fetchAllTrainers()


    }

    func autoLogin(){
        if let uid = Auth.auth().currentUser?.uid{
            let ref = Database.database().reference().child("user_types")
            
            ref.child(uid).observeSingleEvent(of: .value, with: { (snap) in
                if snap.hasChild("type"){
                    let snapshot = snap.value as! [String:Any]
                    if snapshot.index(forKey: "type") == nil{
                        print("no type exist")
                        return
                    }
                    else{
                        let type = snapshot["type"]! as! String
                        if type  == "user"{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                        else if type  == "trainer" {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
                            self.navigationController?.pushViewController(vc, animated: true)
                            //self.present(vc, animated: true, completion: nil)
                        }
                        else{
                            print("no user")
                            return
                        }
                    }
                }
                else{
                    
                    print("nochild")
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
//                    self.navigationController?.pushViewController(vc, animated: true)
                    do{
                        try Auth.auth().signOut()
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    catch{

                    }
                }
                
                
            }, withCancel: nil)
        }
        else{
            print("no current user in firebase")
        }
    }
    func fetchAllTrainers(){
        let _ = Database.database().reference().child("trainer").observe(.childAdded) { (snap) in
            let dic :Dictionary = snap.value as! [String:Any]
            let trainer = TrainerDetail()
            trainer.setValuesForKeys(dic)
            self.arrTrainerUID.append(snap.key)
            self.arrTrainerDetail.append(trainer)
            self.trendingCV.reloadData()
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
        self.sliderCV.reloadData()
        self.availableWorkoutTV.reloadData()
        SVProgressHUD.dismiss()
    }
}

extension LandingVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return availableWorkouts.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let workout = availableWorkouts[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerTableViewCell1") as! TrainerTableViewCell1
            cell.btnSeeMore.tag = indexPath.row
            cell.availableWorkoutLabel.text = workout.workout_category
            cell.availworkoutImg.sd_setImage(with: URL(string: workout.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
            if let seconds = workout.workout_time{
                let timestampDate = Date(timeIntervalSince1970: TimeInterval(truncating: seconds)).timeAgoSinceNow
                //  let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = "hh:mm:ss a"
                cell.availTimelbl.text  = timestampDate
                
            }
            return cell
      
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
        navigationController?.pushViewController(registerViewController, animated: true)
            
        }
    }
    
extension LandingVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCV{
            let workout = availableWorkouts[indexPath.row]
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell1", for: indexPath) as! TrainerCollectionViewCell1
            cell1.scrollImg.sd_setImage(with: URL(string: workout.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
            
            return cell1
            
        }else if collectionView == trendingCV {
            let trainer = arrTrainerDetail[indexPath.row]
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell2", for: indexPath) as! TrainerCollectionViewCell2
            cell2.cell2Img.sd_setImage(with: URL(string: trainer.imageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
            cell2.cell2Lbl.text = trainer.name ?? ""
            cell2.cell2Img.layer.cornerRadius = cell2.cell2Img.frame.width/2
            cell2.cell2Img.clipsToBounds = true
            return cell2
        }else {
            //  let work  = workouts[indexPath.row]
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell3", for: indexPath) as! TrainerCollectionViewCell3
            //cell3.cell3Img.sd_setImage(with: URL(string: work.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
            //cell3.cell3Lbl.text = work.workout_time
            return cell3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.sliderCV{
            return availableWorkouts.count
        }else if collectionView == trendingCV{
            return arrTrainerDetail.count
        }else {
            return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.sliderCV{
            return 0
        }else if collectionView == trendingCV{
            return 0
        }else {
            return 5
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.sliderCV{
            
            let itemWidth = collectionView.bounds.width
            let itemHeight = collectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight)
        }else if collectionView == trendingCV{
            
            
            
            let itemsPerRow:CGFloat = 4
            
            let itemWidth = (collectionView.bounds.width / itemsPerRow)
            let itemHeight = (collectionView.bounds.width / itemsPerRow)
            return CGSize(width: itemWidth, height: itemHeight)
            
        }else{
            let itemsPerRow:CGFloat = 3
            let itemWidth = (collectionView.bounds.width / itemsPerRow)
            let itemHeight = (collectionView.bounds.width / itemsPerRow)
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    
    
}




















