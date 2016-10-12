//
//  AddNewPOIViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 10/3/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

class AddNewPOIViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickJobType = PersonData.JobTypes.self
    var pickNetWorkStatus = PersonData.NetworkStatus.self
    var firstPickerView: UIPickerView?
    var secondPickerView: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        firstPickerView?.delegate = self
        
        jobTypeLabel.inputView = firstPickerView
        networkStatusLabel.inputView = secondPickerView
        
        let subCount = countIt(&pickJobType)
        print("The number of choices in the picker is ")
        
    }

    @IBOutlet weak var fullNameLabel: UITextField!
    
    @IBOutlet weak var compNameLabel: UITextField!
    
    @IBOutlet weak var jobTypeLabel: UITextField!
    
    @IBOutlet weak var networkStatusLabel: UITextField!
    
    @IBOutlet weak var standOutInfoLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    
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
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
       // saveButton.isEnabled = false  //havent implemented yet ***
        
    }
    
    //MARK: PickerViews
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if pickerView == firstPickerView {
           let arrayLabel: [String] = [String(describing: pickJobType.Developer), String(describing: pickJobType.Designer), String(describing: pickJobType.Investor), String(describing: pickJobType.Management), String(describing: pickJobType.Entrepreneur), String(describing: pickJobType.other)]
            count = arrayLabel.count
            
        } else { if pickerView == secondPickerView {
            let arrayLabel: [String] = [String(describing: pickNetWorkStatus.ImportantPerson), String(describing: pickNetWorkStatus.Connection), String(describing: pickNetWorkStatus.MightNeedThereHelp), String(describing: pickNetWorkStatus.WouldLikeToWorkWith), String(describing: pickNetWorkStatus.VIP)]
            count = arrayLabel.count
            }
           
        }
        //put the final return here
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstPickerView {
            let arrayLabel: [String] = [String(describing: pickJobType.Developer), String(describing: pickJobType.Designer), String(describing: pickJobType.Investor), String(describing: pickJobType.Management), String(describing: pickJobType.Entrepreneur), String(describing: pickJobType.other)]
            return arrayLabel[row]
            
        } else { if pickerView == secondPickerView {
            let arrayLabel: [String] = [String(describing: pickNetWorkStatus.ImportantPerson), String(describing: pickNetWorkStatus.Connection), String(describing: pickNetWorkStatus.MightNeedThereHelp), String(describing: pickNetWorkStatus.WouldLikeToWorkWith), String(describing: pickNetWorkStatus.VIP)]
            return arrayLabel[row]
            }
            
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if pickerView == firstPickerView {
            let arrayLabel: [String] = [String(describing: pickJobType.Developer), String(describing: pickJobType.Designer), String(describing: pickJobType.Investor), String(describing: pickJobType.Management), String(describing: pickJobType.Entrepreneur), String(describing: pickJobType.other)]
           jobTypeLabel.text = arrayLabel[row]
            
        } else { if pickerView == secondPickerView {
            let arrayLabel: [String] = [String(describing: pickNetWorkStatus.ImportantPerson), String(describing: pickNetWorkStatus.Connection), String(describing: pickNetWorkStatus.MightNeedThereHelp), String(describing: pickNetWorkStatus.WouldLikeToWorkWith), String(describing: pickNetWorkStatus.VIP)]
           networkStatusLabel.text = arrayLabel[row]
            }
            
        }
        
    }
    // A Generic function that will count an array of any type!!
    func countIt<T>(_ temp: [T]) -> Int {
        let count = temp.count
        return count
    }
    
    
    

}
