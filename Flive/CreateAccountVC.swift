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
    @IBOutlet weak var popBackView: UIView!
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

    @IBOutlet weak var mobileField: UITextField!

    @IBOutlet weak var lblSelectedDOB: UILabel!
    @IBOutlet weak var lblSelectedGender: UILabel!
    @IBOutlet weak var lblSelectedCountry: UILabel!
    var userUid : String?
    var typeOfUser : String = "user"
    var fbImageUrl : String?
    var fbGender: String?
    var fbName : String?
    var countries: [String] = []
    var gender: [String] = ["Male","Female"]
    var selectedGender : String? = "Male"
    var selectedCountry : String? = "Ascension Island"
    var selectedDOB : String? = ""
   // var selectedGender : String?
    let call = Functions()
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: - UI Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getContentReady()
        //Blur popup start
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popBackView.addSubview(blurEffectView)
        //Blur popup End
        if fbImageUrl != nil {
            let imUrl = URL(string: fbImageUrl!)
            let imData = try? Data(contentsOf: imUrl!)
            profileImg.image = UIImage(data: imData!)
            self.profileImg.contentMode = .scaleAspectFit
            self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2
            self.profileImg.clipsToBounds = true
            self.profileImg.layer.borderColor = UIColor(red: 217/255, green: 255/255, blue: 0/255, alpha: 1).cgColor
            self.profileImg.layer.borderWidth = 2.0
        }
        if fbName != nil{
            nameField.text = fbName
        }
        if fbGender != nil{
            lblSelectedGender.text = fbGender
        }
        userUid = Auth.auth().currentUser?.uid
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        
        print(countries)
        nameField.attributedPlaceholder = NSAttributedString(string: "Your name*",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        mobileField.attributedPlaceholder = NSAttributedString(string: "Mobile*",
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
    //MARK: - SetupUI
    func getContentReady()  {
        dobDatePicker.maximumDate = Date()
        
        countryViewForPicker.layer.cornerRadius = 10
        dobViewForPicker.layer.cornerRadius = 10
        genderViewForPicker.layer.cornerRadius = 10
        countryViewForPicker.clipsToBounds = true
        dobViewForPicker.clipsToBounds = true
        genderViewForPicker.clipsToBounds = true
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(handleGenderAction))
        lblSelectedGender.isUserInteractionEnabled = true
        lblSelectedGender.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleCountryAction))
        lblSelectedCountry.isUserInteractionEnabled = true
        lblSelectedCountry.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(handleDOBAction))
        lblSelectedDOB.isUserInteractionEnabled = true
        lblSelectedDOB.addGestureRecognizer(tap3)
    }
    
     // MARK: - HandleActions
    @IBAction func handleDOBDone(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: dobDatePicker.date)
        self.lblSelectedDOB.text = strDate
        selectedDOB = strDate
        //sleep(1)
        dobViewForPicker.isHidden = true
         popBackView.isHidden = true
    }
    @IBAction func handleCountryDone(_ sender: Any) {
        countryViewForPicker.isHidden = true
        popBackView.isHidden = true
        self.lblSelectedCountry.text = selectedCountry
    }
    @IBAction func handleGenderDone(_ sender: Any) {
        genderViewForPicker.isHidden = true
        popBackView.isHidden = true
        self.lblSelectedGender.text = selectedGender
    }
    @IBAction func handleSegTypeUser(_ sender: Any) {
        if segTypeUser.selectedSegmentIndex == 0{
            typeOfUser = "user"
        }
        else{
            typeOfUser = "trainer"
        }
    }
   
    @objc func handleGenderAction() {
         popBackView.isHidden = false
        self.view!.endEditing(true)
        genderViewForPicker.isHidden = false
    }
    @objc func handleCountryAction() {
         popBackView.isHidden = false
        self.view!.endEditing(true)
        countryViewForPicker.isHidden = false
    }
    @objc func handleDOBAction() {
         popBackView.isHidden = false
        self.view!.endEditing(true)
        dobViewForPicker.isHidden = false
    }
    
    @IBAction func ContinueWidDetail(_ sender: UIButton) {
        if profileImg.image == #imageLiteral(resourceName: "ic_addimg"){
            call.showAlertWithoutAction(title: "Error", message: "Profile picture is required", view: self)
        }
        else if nameField.text == ""{
            call.showAlertWithoutAction(title: "Error", message: "Name is required", view: self)
        }
        else if lblSelectedDOB.text == "Select"{
            call.showAlertWithoutAction(title: "Error", message: "DOB is required", view: self)
        }
        else if lblSelectedGender.text == "Select"{
            call.showAlertWithoutAction(title: "Error", message: "Gender is required", view: self)
        }
        else if mobileField.text == ""{
            call.showAlertWithoutAction(title: "Error", message: "Mobile is required", view: self)
        }
        else if lblSelectedCountry.text == "Select"{
            call.showAlertWithoutAction(title: "Error", message: "Country is required", view: self)
        }
        else{
            SVProgressHUD.show()
            let storageRef = Storage.storage().reference().child("profile_images").child("\(userUid!).jpg")
            //if let uploadData = UIImagePNGRepresentation(self.profileImage.image!)
            if let uploadData = UIImageJPEGRepresentation(profileImg.image!, 0.10){
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                    if err != nil {
                        
                        return
                    }
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let ref = Database.database().reference().child(self.typeOfUser)
                        let ref2 = Database.database().reference().child("user_types")
                        if self.userUid != nil{
                            ref2.child(self.userUid!).updateChildValues(["type":self.typeOfUser])
                            let post = ["name": self.nameField.text!,
                                        "age": self.selectedDOB!,
                                        "mobile": self.mobileField.text!,
                                        "country": self.selectedCountry!,
                                        "gender": self.selectedGender!,
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
    @objc func actionImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                self.call.showAlertWithoutAction(title: "Error", message: "Camera not available", view: self)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action : UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
             self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }

    
}
extension CreateAccountVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        mobileField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
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
            self.profileImg.layer.borderColor = UIColor.green.cgColor
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
            self.selectedGender = gender[row]
        }
        else{
            self.selectedCountry = countries[row]
        }
        
    }
    
}
