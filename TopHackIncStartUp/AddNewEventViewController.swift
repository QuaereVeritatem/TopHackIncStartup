//
//  AddNewEventViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 9/28/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//
//problems here: picture button crash and first pickerview option not selectable at first

import UIKit

class AddNewEventViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickProgTyp = EventData.sharedInstance.progTypesArray
    var pickLocation = EventData.sharedInstance.areaLocArray
    var pickDate = EventData.sharedInstance.timeFrameArray
    
    var photoImageViewText: String?
    
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
        //imagePickerController(_, _)
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
        var photo = UIImage(named: "defaultLogo1")
        
        let name = progNameLabel.text ?? ""
        let web = websiteLink.text ?? ""
        let progT = progTypeLabel
        let progL = progLocation
        let dateL = dateLabel
        
        //next line causing fatal run-time crash (bad way to unwrap optional!! *******)
        if photoImageView.image != nil {
            photo = photoImageView.image  //not tied to anything yet
            //update the struct Event logo = photoName (strjng) ***
            EventData.sharedInstance.testEvent.logo = photoImageViewText
        } else { EventData.sharedInstance.testEvent.logo! = "defaultLogo1"
            photo = UIImage(named: "defaultLogo1")
        }
        EventData.sharedInstance.testEvent.name = name
        
        //** mapping raw value allows userdefined types to be set to text input fields **
        EventData.sharedInstance.testEvent.areaLoc = (progL?.text).map { EventData.AreaLoc(rawValue: $0) }!
        
        EventData.sharedInstance.testEvent.dateOrTimeFrame = (dateL?.text).map { EventData.TimeFrame(rawValue: $0) }!
        
        EventData.sharedInstance.testEvent.progType = (progT?.text).map { EventData.ProgTypes(rawValue: $0) }!
        
        EventData.sharedInstance.testEvent.progUrl = web
        
        //adding to local database
        EventData.sharedInstance.besthackIncEvent.append(EventData.sharedInstance.testEvent)
       
        //adding to backendless class(so it can be stored in backendless) [storing in dual format]
        let backendlessTH: BackendlessTopHack = BackendlessTopHack()
        let newName = EventData.sharedInstance.testEvent.name
        //if let newPhoto =
        //change this photo to the default...it will crash as is ****!!!!!!!!!!!
        let hackIS: HackIncStartUp = HackIncStartUp.init(name: newName, photo: photo)!
        
        backendlessTH.EventLogo = EventData.sharedInstance.testEvent.logo
        backendlessTH.EventName = EventData.sharedInstance.testEvent.name
        backendlessTH.EventAreaLoc = EventData.sharedInstance.testEvent.areaLoc.map { $0.rawValue }
        backendlessTH.EventDate = EventData.sharedInstance.testEvent.dateOrTimeFrame.map { $0.rawValue }
        backendlessTH.EventProgramType = EventData.sharedInstance.testEvent.progType.map { $0.rawValue }
        backendlessTH.Website = EventData.sharedInstance.testEvent.progUrl
        
        hackIS.areaLoc = EventData.sharedInstance.testEvent.areaLoc
        hackIS.dateOrTimeFrame = EventData.sharedInstance.testEvent.dateOrTimeFrame
        hackIS.progType = EventData.sharedInstance.testEvent.progType
        hackIS.progUrl = EventData.sharedInstance.testEvent.progUrl


        let dualFormatEvent: (BackendlessTopHack,HackIncStartUp) = (backendlessTH, hackIS)
        
        //change new data added to jSON
        if let json = backendlessTH.toJSON() {
            print("The json thats been serialized from BackTopHack is \(json)") }
        
        //saving to backendless part
        spinner.startAnimating()
        
        //save the event earlier that we appended (dont save the whole array over again)
        BackendlessManager.sharedInstance.saveEvent(newEventData: dualFormatEvent,
             completion: {
             
             // It was saved to the database!
             self.spinner.stopAnimating()
             
             //self.meal?.replacePhoto = false // Reset this just in case we did a photo replacement.
             
            //send back to event VC
                print("Prob maybe NewEventSegueBack 1")
             self.performSegue(withIdentifier: "NewEventSegueBack", sender: self)
             },
             
             error: {
             
             // It was NOT saved to the database! - tell the user and DON'T call performSegue.
             self.spinner.stopAnimating()
             
             let alertController = UIAlertController(title: "Save Error",
             message: "Oops! We couldn't save your Event at this time.",
             preferredStyle: .alert)
             
             let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
             alertController.addAction(okAction)
             
             self.present(alertController, animated: true, completion: nil)
             
             self.saveButton.isEnabled = true
             
             })
            
        
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
        //setting text equal to pic text
        // MARK : Problem here... optional not properly unwrapped
        photoImageViewText = UIImagePickerControllerOriginalImage
        print("The picture is named.... \(photoImageViewText)")
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage //this or prev line causes crash*****
        
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
        return 1
    }
    
     // MARK : Problem here pickerview 1st choice not registering 
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
    
    // MARK : Problem here pickerview 1st choice not registering
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //1st choice not registering
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
    
     // MARK : Problem here pickerview 1st choice not registering
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
