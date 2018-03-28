//
//  CreateAccountVC.swift
//  Flive
//
//  Created by iosteam on 3/21/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import Photos
import SVProgressHUD
class CreateAccountVC: UIViewController {
    @IBOutlet weak var segTypeUser: UISegmentedControl!
    @IBOutlet weak var lblmobile: UILabel!
     @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var genderViewForPicker: UIView!
    @IBOutlet weak var countryViewForPicker: UIView!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBOutlet weak var dobViewForPicker: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    var userUid : String?
    var typeOfUser : String = "user"
    var pickedImage = UIImage()
    var countries: [String] = []
    var gender: [String] = ["Male","Female"]
    let call = Functions()
    override func viewDidLoad() {
    super.viewDidLoad()
        userUid = Auth.auth().currentUser?.uid
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        
        print(countries)
        nameField.attributedPlaceholder = NSAttributedString(string: "Your name*",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        ageField.attributedPlaceholder = NSAttributedString(string: "Select",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        mobileField.attributedPlaceholder = NSAttributedString(string: "Mobile*",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        countryField.attributedPlaceholder = NSAttributedString(string: "Select",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        genderField.attributedPlaceholder = NSAttributedString(string: "Select",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionImage))
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(tap)
        lblname.isHidden = true
        lblmobile.isHidden = true
   // imagePicker.tap
    }
    override func viewWillAppear(_ animated: Bool) {
self.checkPermission()
    }

    @IBAction func ContinueWidDetail(_ sender: UIButton) {
        
        SVProgressHUD.show()
        let storageRef = Storage.storage().reference().child("profile_images").child("\(userUid!).jpg")
        //if let uploadData = UIImagePNGRepresentation(self.profileImage.image!)
        if let uploadData = UIImageJPEGRepresentation(profileImg.image!, 0.10){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if err != nil {
                    
                    return
                }
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    let ref = Database.database().reference()
                    if self.userUid != nil{
                        let post = ["name": self.nameField.text!,
                                    "age": self.ageField.text!,
                                    "mobile": self.mobileField.text!,
                                    "country": self.countryField.text!,
                                    "gender": self.genderField.text!,
                                    "type": self.typeOfUser,
                                    "imageUrl": profileImageUrl] as [String : Any]
                        ref.child(self.userUid!).updateChildValues(post, withCompletionBlock: { (error, reff) in
                            if error != nil {
                                print(error ?? "")
                                return
                            }
                            SVProgressHUD.dismiss()
                            if self.typeOfUser == "user"{
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
                               self.navigationController?.pushViewController(vc, animated: true)
                            
                            }  
                            else{
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerDetailVC") as! TrainerDetailVC
                                self.navigationController?.pushViewController(vc, animated: true)
                                //self.present(vc, animated: true, completion: nil)
                            }
                        })
                    }
                }
                
                
                print(metadata ?? "")
            })
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func handleSegTypeUser(_ sender: Any) {
        if segTypeUser.selectedSegmentIndex == 0{
            typeOfUser = "user"
        }
        else{
            typeOfUser = "trainer"
        }
    }
    @IBAction func handleDOB(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: dobDatePicker.date)
        self.ageField.text = strDate
        sleep(1)
        dobViewForPicker.isHidden = true
        
    }
  
    @objc func actionImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker Delegate
  
    
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
}
extension CreateAccountVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        ageField.resignFirstResponder()
        mobileField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case ageField:
            dobViewForPicker.isHidden = false
            ageField.resignFirstResponder()
        case countryField:
            countryViewForPicker.isHidden = false
            countryField.resignFirstResponder()
        case genderField:
            genderViewForPicker.isHidden = false
            genderField.resignFirstResponder()
        case mobileField:
            lblmobile.isHidden = false
        case nameField:
            lblname.isHidden = false
           
            
        default:
            print("opps")
        }
    }
}
extension CreateAccountVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker : UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }
        else if let orignalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = orignalImage
        }
        if let selectedImage = selectedImageFromPicker {
            self.profileImg.image = selectedImage
            self.profileImg.contentMode = .scaleAspectFit
            self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2
            self.profileImg.clipsToBounds = true
            self.profileImg.layer.borderColor = UIColor.orange.cgColor
            self.profileImg.layer.borderWidth = 2.0
        }
        dismiss(animated: true, completion: nil)
    }
}
extension CreateAccountVC : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPicker{
            return gender.count
        }
        else{
            return countries.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPicker{
            return gender[row]
        }
        else{
            return countries[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker{
            genderField.text = gender[row]
            genderViewForPicker.isHidden = true
        }
        else{
            countryField.text = countries[row]
            countryViewForPicker.isHidden = true
        }
        
    }
    
}
