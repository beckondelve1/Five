//
//  UserProfileVC.swift
//  Flive
//
//  Created by iosteam on 3/26/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {
    
    let myimages = ["cat_1","cat_2","cat_5","cat_6",]
    @IBOutlet weak var collectionview1: UICollectionView!
    
    @IBOutlet weak var collectionview2: UICollectionView!
    @IBOutlet weak var userprofileName: UILabel!
    @IBOutlet weak var userprofileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

      userprofileImg.layer.cornerRadius = userprofileImg.frame.height/2
        userprofileImg.clipsToBounds = true
    }

    //MARK:- Tab Menu
    @IBAction func handleHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func handleMenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menuCataVC") as! menuCataVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func handleLiveWorkout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserLiveWorkoutVC") as! UserLiveWorkoutVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func handleNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "notificationVC") as! notificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
  

}


extension UserProfileVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionview1{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "UserprofileCell1", for: indexPath) as! UserprofileCell1
            cell1.currentworkoutImg.image = UIImage(named:myimages[indexPath.row])
            return cell1
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProfileCell2", for: indexPath) as! UserProfileCell2
            cell2.completedworkouts.image = UIImage(named:myimages[indexPath.row])
            return cell2
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        if collectionView == self.collectionview1{
//            
//            let itemperrow:CGFloat = 2
//            
//            
//            
//            let itemWidth = collectionView.bounds.width/itemperrow
//            let itemHeight = collectionView.bounds.height/itemperrow
//            return CGSize(width: itemWidth, height: itemHeight)
//        }else{
//            
//            
//            
//            let itemsPerRow:CGFloat = 2
//            
//            let itemWidth = (collectionView.bounds.width / itemsPerRow)
//            let itemHeight = (collectionView.bounds.width / itemsPerRow)
//            return CGSize(width: itemWidth, height: itemHeight)
//            
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == collectionview1 {
//            return 5
//        }else{
//            return 5
//        }
//    }
    
}
