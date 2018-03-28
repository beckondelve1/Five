//
//  CreateAccount1TVC.swift
//  Flive
//
//  Created by mac for ios on 3/13/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase

class CreateAccount1TVC: UIViewController,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!

    @IBOutlet weak var mobileField: UITextField!
    
    @IBOutlet weak var typeAccountField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    
    var uploaded = Bool ()
    var userUid : String?
@IBOutlet var btn_UserImg: UIButton!
    let imagePicker = UIImagePickerController()
    var pickedImage = UIImage()
    
    @IBOutlet weak var pickedimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        uploaded = false
        //self.datesPicker.isHidden = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateAccount1TVC.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        
    }
    
    
   
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ContinueWidDetail(_ sender: UIButton) {
        let ref = Database.database().reference()
        if userUid != nil{
            let post = ["name": nameField.text!,
                        "age": ageField.text,
                        "mobile": mobileField.text!,
                        "country": countryField.text!,
                        "gender": genderField.text!,
                        "type": typeAccountField.text!,
                        "imageUrl": "url"] as [String : Any]
            ref.child(userUid!).updateChildValues(post, withCompletionBlock: { (error, reff) in
                if error != nil {
                    print(error)
                    return
                }
                
            })
        }
    }

    // MARK: - Table view data source

  

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func actionImage(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        let actionSheetController = UIAlertController(title: "", message: "Select from", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            // Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        // Create and add first option action
        let takePictureAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.imagePicker.cameraDevice = .front
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        actionSheetController.addAction(takePictureAction)
        
        // Create and add a second option action
        let choosePictureAction = UIAlertAction(title: "Gallery", style: .default) { action -> Void in
            
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        actionSheetController.addAction(choosePictureAction)
        // We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as UIView
        
        // Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if (info[UIImagePickerControllerEditedImage] as? UIImage) != nil {
            uploaded = true
            pickedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            var flippedImage = UIImage()
            
            if (picker.sourceType == .camera) {
                
                if (picker.cameraDevice  == .front ) {
                    //                    let  flipped = UIImage (CGImage: pickedImage.CGImage!, scale: pickedImage.scale, orientation:.LeftMirrored)
                    flippedImage = pickedImage
                } else {
                    flippedImage = pickedImage
                }
                
                // Do something with an image from the camera
            } else {
                flippedImage = pickedImage
            }
            
            self.btn_UserImg.contentMode = .scaleAspectFit
            self.btn_UserImg.setBackgroundImage(flippedImage , for: .normal)
            self.btn_UserImg.layer.cornerRadius = self.btn_UserImg.frame.size.width / 2
            self.btn_UserImg.clipsToBounds = true
        }
        
        dismiss(animated: true, completion: {
            UIApplication.shared.isStatusBarHidden = true
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("user cancels uploads")
        
        dismiss(animated: true, completion: {
            UIApplication.shared.isStatusBarHidden = true
        })
    }

    
    
    
}
extension CreateAccount1TVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        ageField.resignFirstResponder()
        mobileField.resignFirstResponder()
        return true
    }
}
