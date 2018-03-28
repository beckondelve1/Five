//
//  LandingVC.swift
//  Flive
//
//  Created by mac for ios on 3/9/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
class LandingVC: UIViewController {
    let myimages = ["11","12","13"]
    let mylabel = ["Logan","Peter","Ethen"]
    let workoutlength = ["5 min","10 min","15 min"]

    @IBAction func user(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
        navigationController?.pushViewController(registerViewController, animated: true)

    }
    @IBAction func play(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
        navigationController?.pushViewController(registerViewController, animated: true)

    }
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
     self.navigationController?.isNavigationBarHidden = true
        self.autoLogin()

    }

    func autoLogin(){
        if let uid = Auth.auth().currentUser?.uid{
            let ref = Database.database().reference()
            ref.child(uid).observeSingleEvent(of: .value, with: { (snap) in
                let snapshot = snap.value as! [String:Any]
                let type = snapshot["type"]! as! String
                if type  == "user"{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true, completion: nil)
                }
            }, withCancel: nil)
        }
    }
}
extension LandingVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView1 {

            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "LandingVCCell1", for: indexPath) as! LandingVCCell1
            cellA.scrollingImages.image = UIImage (named: myimages[indexPath.row])
            
        
            return cellA
        }
            
        else {

            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "LandingVCCell2", for: indexPath) as! LandingVCCell2
            cellB.scrolledimage.image = UIImage (named: myimages[indexPath.row])
            cellB.scrolledimage.layer.cornerRadius = cellB.scrolledimage.frame.width/2
            cellB.scrolledimage.clipsToBounds = true
            cellB.label1.text = mylabel[indexPath.row]
            return cellB
        }
       
    
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView1 {
            return myimages.count
        }else{
            return myimages.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView1{
            
            let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
            navigationController?.pushViewController(registerViewController, animated: true)
            
        }
        else
        {
            let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
                navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionView1{
    
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
        }else{
           
           
        
            let itemsPerRow:CGFloat = 4
           
            let itemWidth = (collectionView.bounds.width / itemsPerRow)
            let itemHeight = (collectionView.bounds.width / itemsPerRow)
            return CGSize(width: itemWidth, height: itemHeight)
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionView1 {
            return 0
        }else{
            return 0
        }
    }
    
}
extension LandingVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myimages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TablesCell", for: indexPath) as! TablesCell
        cell.TablesThumbImg.image = UIImage(named: myimages[indexPath.row])
        cell.TablesThumbImg.layer.cornerRadius = 2
        cell.TablesThumbImg.clipsToBounds = true
        cell.lblTime.text = workoutlength[indexPath.row]
        cell.TablesLabel.text = mylabel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerationViaSocialVC") as! registerationViaSocialVC
         navigationController?.pushViewController(registerViewController, animated: true)
        
        
    }
}






















