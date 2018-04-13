//
//  menuCataVC.swift
//  Flive
//
//  Created by mac for ios on 3/14/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class menuCataVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    let menu = ["cat_5","cat_1","cat_6","cat_7"]
    let lbl1 = ["Muscle Building","Weight Loss","Yoga and Core","others"]
    let lbl2 = ["3 Live Workouts","3 Live Workouts","3 Live Workouts","3 Live Workouts"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCategoriesCell", for: indexPath) as! menuCategoriesCell
        cell.menuImg.image = UIImage(named: menu[indexPath.row])
        cell.menuLbl1.text = lbl1[indexPath.row]
        cell.menuLbl2.text = lbl2[indexPath.row]
        return cell
    }
    
    //MARK:- Tab Menu
    @IBAction func handleHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
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
}
