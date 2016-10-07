//
//  AddNewEventViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 9/28/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

class AddNewEventViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    struct hackEvent {
        
        var name: String //program name
        var progUrl: String? //website...should be an optional
        var progType: ProgTypes? //should be an optional
        var areaLoc: AreaLoc? //location should be optional
        var logo: String? //should be an optional in case no logo added
        var dateOrTimeFrame: TimeFrame?  //should be optional
    }
    
    enum ProgTypes {
        case accelerator
        case hackathon
        case bootcamp
        case incubator
        case startUpPitch
        case networking
        
    }
    
    enum AreaLoc {
        case Worldwide
        case Dallas
        case Nationwide
        case Austin
        case Mountainview
        case SanFran_NYC
        case NYC
        
    }
    
    enum TimeFrame {
        case yearly
        case monthly
        case weekly
        case specificMonth(TwelveMonths)
        case specificDate(Int, Int, Int) //implement pickerview on months that use this variable month,day,year
        
    }
    
    enum TwelveMonths {
        case January
        case February
        case March
        case April
        case May
        case June
        case July
        case August
        case September
        case October
        case November
        case December
    }

    var hackInc = [hackEvent]()
    
    @IBOutlet weak var progNameLabel: UITextField!
    
    @IBOutlet weak var websiteLink: UITextField!
    
    @IBOutlet weak var progTypeLabel: UITextField! //should be tied to pickerView
    
    @IBOutlet weak var progLocation: UITextField!  //should be tied to pickerView
    
    @IBOutlet weak var dateLabel: UITextField!     //should be tied to pickerView
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //image not connected..delete and put imageview under transparent button (same autolayout)
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func photoImageButton(_ sender: UIButton) {
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        // ****This dismiss (cancel) VC function not working!!!
        let isPresentingInAddEventMode = presentingViewController is UINavigationController
        
        if isPresentingInAddEventMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
         saveButton.isEnabled = false
        
        //programName
        let name = progNameLabel.text ?? ""
          let web = websiteLink.text ?? ""
            let progT = progTypeLabel
            let progL = progLocation
            let dateL = dateLabel
 
        let photo = photoImageView.image //not tied to anything yet
        //update the struct Event
        hackInc[hackEvent.name] = name
        hackInc. , progUrl: web, progType: progT, areaLoc: progL, logo: photo , dateOrTimeFrame: dateL)
        

        HomeVC.besthackIncEvent.append(hackInc(name: name, progUrl: web, progType: progT, areaLoc: progL, logo: photo , dateOrTimeFrame: dateL))
        
        
        if BackendlessManager.sharedInstance.isUserLoggedIn() {
            
            // We're logged in - attempt to save to Backendless!
            spinner.startAnimating()
            
/*            BackendlessManager.sharedInstance.saveMeal(mealData: meal!,
                                                       
             completion: {
             
             // It was saved to the database!
             self.saveSpinner.stopAnimating()
             
             self.meal?.replacePhoto = false // Reset this just in case we did a photo replacement.
             
             self.performSegue(withIdentifier: "unwindToMealList", sender: self)
             },
             
             error: {
             
             // It was NOT saved to the database! - tell the user and DON'T call performSegue.
             self.saveSpinner.stopAnimating()
             
             let alertController = UIAlertController(title: "Save Error",
             message: "Oops! We couldn't save your Meal at this time.",
             preferredStyle: .alert)
             
             let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
             alertController.addAction(okAction)
             
             self.present(alertController, animated: true, completion: nil)
             
             self.saveButton.isEnabled = true
             
             })
            
        } else {
            
            // We're not logged in - just unwind and have MealTableViewController
            // save later using NSKeyedArchiver.
            self.performSegue(withIdentifier: "unwindToMealList", sender: self) */
            
        }
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        progNameLabel.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //make sure field not empty 
        checkValidEventName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func checkValidEventName() {
        // Disable the Save button if the text field is empty.
        let text = progNameLabel.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    


}
