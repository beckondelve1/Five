//
//  UserSettingVC.swift
//  Flive
//
//  Created by iosteam on 3/27/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase

class UserSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleSignout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }
        catch{
            
        }
        
    }
}
