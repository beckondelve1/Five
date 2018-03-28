//
//  homeVC.swift
//  Flive
//
//  Created by mac for ios on 3/14/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import AVKit

class homeVC: UIViewController {

    
        let myimages = ["11","12","13"]
        let categories = ["Building Muscles","Weight Loss","Yoga and Core"]
        let workoutlength = ["5 min","10 min","20 min"]
        let arrVideos = ["11","12","13"]
        @IBOutlet weak var CollectionView1: UICollectionView!
        @IBOutlet weak var CollectionView2: UICollectionView!
        @IBOutlet weak var CollectionView3: UICollectionView!
        @IBOutlet weak var TableViewWorkout: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
    }
    
    extension homeVC: UITableViewDataSource,UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return myimages.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerTableViewCell1") as! TrainerTableViewCell1
            cell.availableWorkoutLabel.text = categories[indexPath.row]
            cell.availworkoutImg.image = UIImage(named:myimages[indexPath.row])
            cell.availTimelbl.text = workoutlength[indexPath.row]
            return cell
        }
        
    }
    
    
    
    
    extension homeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == CollectionView1{
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell1", for: indexPath) as! TrainerCollectionViewCell1
                cell1.scrollImg.image = UIImage(named: myimages[indexPath.row])
                
                return cell1
                
            }else if collectionView == CollectionView2 {     let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell2", for: indexPath) as! TrainerCollectionViewCell2
                cell2.cell2Img.image = UIImage(named: myimages[indexPath.row])
                cell2.cell2Lbl.text = categories[indexPath.row]
                cell2.cell2Img.layer.cornerRadius = cell2.cell2Img.frame.width/2
                cell2.cell2Img.clipsToBounds = true
                return cell2
            }else {
                let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell3", for: indexPath) as! TrainerCollectionViewCell3
                cell3.cell3Img.image = UIImage(named: myimages[indexPath.row])
                cell3.cell3Lbl.text = workoutlength[indexPath.row]
                return cell3
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.CollectionView1{
                return myimages.count
            }else if collectionView == CollectionView2{
                return myimages.count
            }else {
                return myimages.count
                
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
            
            let url = NSURL(fileURLWithPath: path!)
            
            //let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            let player = AVPlayer(url: url as URL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
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
