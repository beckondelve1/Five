//
//  UserVC.swift
//  Flive
//
//  Created by mac for ios on 3/14/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import AVKit
import SVProgressHUD
import Firebase

class UserVC: UIViewController {
    let myimages = ["11","12","13"]
    let categories = ["Building Muscles","Weight Loss","Yoga and Core"]
    let workoutlength = ["5 min","10 min","20 min"]
    let arrVideos = ["11","12","13"]
    @IBOutlet weak var CollectionView1: UICollectionView!
    @IBOutlet weak var CollectionView2: UICollectionView!
    @IBOutlet weak var CollectionView3: UICollectionView!
    @IBOutlet weak var TableViewWorkout: UITableView!
    
    let call = Functions()
    var arrTrainerUID = [String]()
    var arrTrainerDetail = [TrainerDetail]()
    var availableWorkouts = [Workouts]()
    var comingSoonWorkouts = [Workouts]()
    var dicComingSoonWorkouts = [String:Workouts]()
    var dicAvailableWorkouts = [String:Workouts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       fetchAllTrainers()
        fetchAllWorkouts()
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
    @IBAction func handleProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    func fetchAllTrainers(){
        let _ = Database.database().reference().child("trainer").observe(.childAdded) { (snap) in
            let dic :Dictionary = snap.value as! [String:Any]
            let trainer = TrainerDetail()
            trainer.setValuesForKeys(dic)
            self.arrTrainerUID.append(snap.key)
            self.arrTrainerDetail.append(trainer)
            self.CollectionView2.reloadData()
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
        self.CollectionView1.reloadData()
        self.TableViewWorkout.reloadData()
        SVProgressHUD.dismiss()
    }

}

extension UserVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.TableViewWorkout{
                return availableWorkouts.count
        }else{
            return comingSoonWorkouts.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.TableViewWorkout{
            let workout = availableWorkouts[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerTableViewCell1") as! TrainerTableViewCell1
            //cell.btnSeeMore.tag = indexPath.row
            cell.availableWorkoutLabel.text = workout.workout_category
            cell.availworkoutImg.sd_setImage(with: URL(string: workout.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
            if let seconds = workout.workout_time{
                let timestampDate = Date(timeIntervalSince1970: TimeInterval(truncating: seconds)).timeAgoSinceNow
                //  let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = "hh:mm:ss a"
                cell.availTimelbl.text  = timestampDate
                
            }
            return cell
        }else{
            let workout = comingSoonWorkouts[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerComingSoonTVC") as! TrainerComingSoonTVC
            cell.workoutDisc.text = workout.workout_title
            cell.workoutImg.sd_setImage(with: URL(string: workout.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
            cell.workoutTime.text = "\(workout.workout_length!):00"
            if let seconds = workout.workout_time{
                let timestampDate = Date(timeIntervalSince1970: TimeInterval(truncating: seconds))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, h:mm a"
                cell.workoutPostTime.text  = "Live on \(dateFormatter.string(from: timestampDate))"
                
                
            }
            Database.database().reference().child("trainer").child(workout.trainer_id!).observe(.value) { (snap) in
                let dic :Dictionary = snap.value as! [String:Any]
                let trainer = TrainerDetail()
                trainer.setValuesForKeys(dic)
                cell.trainerName.text = trainer.name ?? ""
                cell.trainerProfileImg.sd_setImage(with: URL(string: trainer.imageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
            }
            return cell
        }
    }
    

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView == TableViewWorkout{
        let workout = availableWorkouts[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AvailableWorkoutVideoVC") as! AvailableWorkoutVideoVC
        vc.videoFullUrl  = workout.workout_video_url ?? ""
        vc.videoThumbnailUrl = workout.workout_thumbnail_url ?? ""
        vc.videoPreviewUrl = workout.workout_preview_video_url ?? ""
        vc.videoThumbnailUrl = workout.workout_preview_thumbnail_url ?? ""
        self.present(vc, animated: true, completion: nil)
        
    }
    else{
        let workout = comingSoonWorkouts[indexPath.row]
        if let seconds = workout.workout_time{
            let timestampDate = Date(timeIntervalSince1970: TimeInterval(truncating: seconds))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm a"
            call.showAlertWithoutAction(title: "Opps", message: "This workout will be live \(dateFormatter.string(from: timestampDate))", view: self)
            
        }
        
    }
}

}


extension UserVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CollectionView1{
            let workout = availableWorkouts[indexPath.row]
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell1", for: indexPath) as! TrainerCollectionViewCell1
            cell1.scrollImg.sd_setImage(with: URL(string: workout.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
            
            return cell1
            
        }else if collectionView == CollectionView2 {
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
        if collectionView == self.CollectionView1{
            return availableWorkouts.count
        }else if collectionView == CollectionView2{
            return arrTrainerDetail.count
        }else {
            return availableWorkouts.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.CollectionView1{
            return 0
        }else if collectionView == CollectionView2{
            return 0
        }else {
           return 5
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let path = Bundle.main.path(forResource: arrVideos[indexPath.row], ofType: "mp4")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoPlayer") as! VideoPlayer
        vc.videoURL = URL(fileURLWithPath: path!)
        self.navigationController?.pushViewController(vc, animated: true)
//        //let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//        let player = AVPlayer(url: url as URL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.CollectionView1{
            
            let itemWidth = collectionView.bounds.width
            let itemHeight = collectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight)
        }else if collectionView == CollectionView2{
            
            
            
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
