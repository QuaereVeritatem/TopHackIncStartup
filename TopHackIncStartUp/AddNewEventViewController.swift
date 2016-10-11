//
//  AddNewEventViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 9/28/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

class AddNewEventViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickProgTyp = EventData.ProgTypes.self
    var pickLocation = EventData.AreaLoc.self
    var pickDate = EventData.TimeFrame.self
    var pickMonths = EventData.TwelveMonths.self
    var pickConvType: [String] = [""]
    
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
            //setting textfields as pickerviews
            let pickerView = UIPickerView()
            pickerView.delegate = self
            
            //set textfields to pullup a pickerview
            progTypeLabel.inputView = pickerView
            progLocation.inputView = pickerView
            dateLabel.inputView = pickerView

       
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
       // EventData.sharedInstance.testEvent.areaLoc = progL  //need to setup pickerview to textfield!!
       // EventData.sharedInstance.testEvent.dateOrTimeFrame = dateL  //need to setup pickerview to textfield!!
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
    
//    func callPickerView(_ inputTextField: UITextField!, _ pickOption: AnyObject){
//        
//       
//        let pickerView = UIPickerView()
//        pickerView.delegate = self
//        inputTextField.inputView = pickerView
//        
//        if inputTextField == progTypeLabel {
//           let convertedPickOp: [String] = pickOption as! [String]
//            pickConvType = convertedPickOp
//        }
//        
//        if inputTextField == progLocation {
//          let convertedPickOp = pickOption as! [String]
//            pickConvType = convertedPickOp
//        }
//        
//        if inputTextField == dateLabel {
//          let convertedPickOp = pickOption as! [String]
//            pickConvType = convertedPickOp
//        }
//
//        
//    }
    
    
    //pickerview not updating...only textfield and not the right way at that
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        //if current textfield/pickerview is dateLabel the make comp X 3
        if pickerView != dateLabel.inputView {
            return 1
        } else {
        
            return 3 }
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //we need to change array to pickConvType so we can get the array count
        //pickerview was set to label's input view..here we're reverse checking what we did earlier, to see if its a match
        if pickerView == progTypeLabel.inputView {
            let arrayLabel: [String] = [String(describing: pickProgTyp.accelerator), String(describing: pickProgTyp.hackathon), String(describing: pickProgTyp.bootcamp), String(describing: pickProgTyp.incubator), String(describing: pickProgTyp.startUpPitch), String(describing: pickProgTyp.networking)]
            return arrayLabel.count  //array at position [row]
        }
        
        if pickerView == progLocation.inputView {
            let arrayLabel: [String] = [String(describing: pickLocation.Worldwide), String(describing: pickLocation.Dallas), String(describing: pickLocation.Nationwide), String(describing: pickLocation.Austin), String(describing: pickLocation.Mountainview), String(describing: pickLocation.SanFran_NYC), String(describing: pickLocation.NYC)]
            return arrayLabel.count        }
        
        if pickerView == dateLabel.inputView {
            var monthsConv: [String] = []
            //set all months to strings
            monthsConv = [String(describing: pickMonths.January), String(describing: pickMonths.February), String(describing: pickMonths.March), String(describing: pickMonths.April), String(describing: pickMonths.May), String(describing: pickMonths.June), String(describing: pickMonths.July), String(describing: pickMonths.August), String(describing: pickMonths.September), String(describing: pickMonths.October), String(describing: pickMonths.November), String(describing: pickMonths.December)]
            
            
            let arrayLabel: [String] = [String(describing: pickDate.yearly), String(describing: pickDate.monthly), String(describing: pickDate.weekly), String(describing: monthsConv.count), String(describing: pickDate.specificDate(monthsConv.count, 31, 2017))] //the last two need to be fixed for custom data entry **dont HARDCODE!
            return arrayLabel.count
        }

        
     return 7  // delete this when we solve above problem
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == progTypeLabel.inputView {
            let arrayLabel: [String] = [String(describing: pickProgTyp.accelerator), String(describing: pickProgTyp.hackathon), String(describing: pickProgTyp.bootcamp), String(describing: pickProgTyp.incubator), String(describing: pickProgTyp.startUpPitch), String(describing: pickProgTyp.networking)]
            return arrayLabel[row]  //array at position [row]
        }
        
        if pickerView == progLocation.inputView {
            let arrayLabel: [String] = [String(describing: pickLocation.Worldwide), String(describing: pickLocation.Dallas), String(describing: pickLocation.Nationwide), String(describing: pickLocation.Austin), String(describing: pickLocation.Mountainview), String(describing: pickLocation.SanFran_NYC), String(describing: pickLocation.NYC)]
            return arrayLabel[row] //array at position [row]
        }
        
        if pickerView == dateLabel.inputView {
            
            var monthsConv: [String] = []
            //set all months to strings
            monthsConv = [String(describing: pickMonths.January), String(describing: pickMonths.February), String(describing: pickMonths.March), String(describing: pickMonths.April), String(describing: pickMonths.May), String(describing: pickMonths.June), String(describing: pickMonths.July), String(describing: pickMonths.August), String(describing: pickMonths.September), String(describing: pickMonths.October), String(describing: pickMonths.November), String(describing: pickMonths.December)]
            
            
            let arrayLabel: [String] = [String(describing: pickDate.yearly), String(describing: pickDate.monthly), String(describing: pickDate.weekly), String(describing: monthsConv), String(describing: pickDate.specificDate(row, row, row))] //the last two need to be fixed for custom data entry
            return arrayLabel[row] //array at position [row]
        }

        return ""
     }
     
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == progTypeLabel.inputView {
            let arrayLabel: [String] = [String(describing: pickProgTyp.accelerator), String(describing: pickProgTyp.hackathon), String(describing: pickProgTyp.bootcamp), String(describing: pickProgTyp.incubator), String(describing: pickProgTyp.startUpPitch), String(describing: pickProgTyp.networking)]
            progTypeLabel.text = arrayLabel[row]  //array at position [row]
        }
        
        if pickerView == progLocation.inputView {
            let arrayLabel: [String] = [String(describing: pickLocation.Worldwide), String(describing: pickLocation.Dallas), String(describing: pickLocation.Nationwide), String(describing: pickLocation.Austin), String(describing: pickLocation.Mountainview), String(describing: pickLocation.SanFran_NYC), String(describing: pickLocation.NYC)]
            progLocation.text = arrayLabel[row] //array at position [row]
        }
        
        if pickerView == dateLabel.inputView {
            
            var monthsConv: [String] = []
            //set all months to strings 
            monthsConv = [String(describing: pickMonths.January), String(describing: pickMonths.February), String(describing: pickMonths.March), String(describing: pickMonths.April), String(describing: pickMonths.May), String(describing: pickMonths.June), String(describing: pickMonths.July), String(describing: pickMonths.August), String(describing: pickMonths.September), String(describing: pickMonths.October), String(describing: pickMonths.November), String(describing: pickMonths.December)]
            
            
            let arrayLabel: [String] = [String(describing: pickDate.yearly), String(describing: pickDate.monthly), String(describing: pickDate.weekly), String(describing: monthsConv), String(describing: pickDate.specificDate(row, row, row))] //the last two need to be fixed for custom data entry
            dateLabel.text = arrayLabel[row] //array at position [row]
        }
        
        
     }
     
    
 


}
