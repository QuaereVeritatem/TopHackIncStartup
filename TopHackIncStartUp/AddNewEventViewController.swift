//
//  AddNewEventViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 9/28/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

class AddNewEventViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickProgTyp = EventData.sharedInstance.progTypesArray
    var pickLocation = EventData.sharedInstance.areaLocArray
    var pickDate = EventData.sharedInstance.timeFrameArray
    
    @IBOutlet weak var progNameLabel: UITextField!
    
    @IBOutlet weak var websiteLink: UITextField!
    
    @IBOutlet weak var progTypeLabel: UITextField! //should be tied to pickerView
    
    @IBOutlet weak var progLocation: UITextField!  //should be tied to pickerView
    
    @IBOutlet weak var dateLabel: UITextField!     //should be tied to pickerView
    
    weak var activeField: UITextField?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let pickerView = UIPickerView()
    
    //image not connected..delete and put imageview under transparent button (same autolayout)
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func photoImageButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //setting textfields as pickerviews
        pickerView.delegate = self
        
        //set textfields to pullup a pickerview
        progTypeLabel.inputView = pickerView
        progLocation.inputView = pickerView
        //try this to fix the errors we be having!!!*****
        // progLocation.inputView = pickerView2
        dateLabel.inputView = pickerView
        //dateLabel.inputView = pickerView3
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
    
    //***Find a better way to do this (ck ios course examples like this)
    @IBAction func save(_ sender: UIBarButtonItem) {
        saveButton.isEnabled = false
        
        let name = progNameLabel.text ?? ""
        let web = websiteLink.text ?? ""
        let progT = progTypeLabel
        let progL = progLocation
        let dateL = dateLabel
        //next line causing fatal run-time crash (bad way to inwrap optional!! *******)
        if photoImageView != nil {
            let photo = photoImageView.image  //not tied to anything yet
        //update the struct Event
    //    EventData.sharedInstance.testEvent.areaLoc = progL  //need to setup pickerview to textfield!!
    //    EventData.sharedInstance.testEvent.dateOrTimeFrame = dateL  //need to setup pickerview to textfield!!
            EventData.sharedInstance.testEvent.logo = photo?.accessibilityIdentifier
        } else { EventData.sharedInstance.testEvent.logo = "defaultLogo1"
        }
        EventData.sharedInstance.testEvent.name = name
       // EventData.sharedInstance.testEvent.progType = progT   //need to setup pickerview to textfield!!
        EventData.sharedInstance.testEvent.progUrl = web
        
        //adding to local database
        EventData.sharedInstance.besthackIncEvent.append(EventData.sharedInstance.testEvent)
        
        //saving to backendless part...
        if BackendlessManager.sharedInstance.isUserLoggedIn() {
            
            // We're logged in - attempt to save to Backendless!
        //    spinner.startAnimating()
            
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
            // save later using NSKeyedArchiver.*/
            self.performSegue(withIdentifier: "NewEventSegueBack", sender: self)
            
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
        //navigationItem.title = textField.text  //this changes nav bar to textfield
        self.activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
        self.activeField = textField
        
        pickerView.reloadAllComponents()
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
        return 1
    }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var count = 1
        
        if self.activeField?.tag == 1 {
            count = EventData.sharedInstance.progTypesArray.count
            print("prog type count is \(EventData.sharedInstance.progTypesArray.count)")
        } else if self.activeField?.tag == 2 {
            count = EventData.sharedInstance.areaLocArray.count
        } else if self.activeField?.tag == 3 {
            count =  EventData.sharedInstance.timeFrameArray.count
        }
        
        return count
     }
    
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var arrayP = "empty"
        
        if self.activeField?.tag == 1 {
            arrayP = EventData.sharedInstance.progTypesArray[row]
        } else if self.activeField?.tag == 2 {
            arrayP = EventData.sharedInstance.areaLocArray[row]
        } else if self.activeField?.tag == 3 {
            arrayP =  EventData.sharedInstance.timeFrameArray[row]
        }
        
        return arrayP
     }
     
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if self.activeField?.tag == 1 {
            progTypeLabel.text = EventData.sharedInstance.progTypesArray[row]
        } else if self.activeField?.tag == 2 {
            progLocation.text = EventData.sharedInstance.areaLocArray[row]
        } else if self.activeField?.tag == 3 {
            dateLabel.text = EventData.sharedInstance.timeFrameArray[row]
        }
    }
}
