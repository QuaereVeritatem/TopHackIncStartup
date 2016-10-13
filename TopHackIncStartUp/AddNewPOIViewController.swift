//
//  AddNewPOIViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 10/3/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

class AddNewPOIViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    let pickerView = UIPickerView()
    var pickJobType = PersonData.JobTypes.self
    var pickNetWorkStatus = PersonData.NetworkStatus.self
    var picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        jobTypeLabel.inputView = pickerView
        networkStatusLabel.inputView = pickerView
    }

    @IBOutlet weak var fullNameLabel: UITextField!
    
    @IBOutlet weak var compNameLabel: UITextField!
    
    @IBOutlet weak var jobTypeLabel: UITextField!
    
    @IBOutlet weak var networkStatusLabel: UITextField!
    
    @IBOutlet weak var standOutInfoLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    weak var activeField: UITextField?
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
    }

    @IBAction func bluetoothSync(_ sender: UIButton) {
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //make sure field not empty
       // checkValidEventName()  // havent implemented yet
       // navigationItem.title = textField.text  //this changes nav bar to textfield
        self.activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
       // saveButton.isEnabled = false  //havent implemented yet ***
        self.activeField = textField
        pickerView.reloadAllComponents()
    }
    
    //MARK: PickerViews
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var count = 0
        
        if self.activeField?.tag == 1 {
            count = PersonData.sharedInstance.jobTypesArray.count
            print("prog type count is \(EventData.sharedInstance.progTypesArray.count)")
        } else if self.activeField?.tag == 2 {
            count = PersonData.sharedInstance.networkStatusArray.count
        }
        print("The size of array is \(count)")
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var arrayP = "empty"
        
        if self.activeField?.tag == 1 {
            arrayP = PersonData.sharedInstance.jobTypesArray[row]  //array at position [row]
        } else if self.activeField?.tag == 2 {
            arrayP = PersonData.sharedInstance.networkStatusArray[row]
        }
        return arrayP
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if self.activeField?.tag == 1 {
            jobTypeLabel.text = PersonData.sharedInstance.jobTypesArray[row]  //array at position [row]
        } else if self.activeField?.tag == 2 {
            networkStatusLabel.text = PersonData.sharedInstance.networkStatusArray[row] //array at position [row]
        }

        
    }
    // A Generic function that will count an array of any type!!
    func countIt<T>(_ temp: [T]) -> Int {
        let count = temp.count
        return count
    }
    
    
    

}
