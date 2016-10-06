//
//  AddNewEventViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 9/28/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

class AddNewEventViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var progNameLabel: UITextField!
    
    @IBOutlet weak var websiteLink: UITextField!
    
    @IBOutlet weak var progTypeLabel: UITextField!
    
    @IBOutlet weak var progLocation: UITextField!
    
    @IBOutlet weak var dateLabel: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
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
        
        
        let name = progNameLabel.text ?? ""
      //  let rating = ratingControl.rating
      //  let photo = photoImageView.image

        
        
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
