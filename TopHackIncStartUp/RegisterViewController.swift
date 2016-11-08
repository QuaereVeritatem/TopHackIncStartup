//
//  RegisterViewController.swift
//  TopHackIncStartup
//
//  Created on 9/4/16.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    let backendless = Backendless.sharedInstance()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        passwordConfirmTextField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        
         emailTextField.layer.cornerRadius = 5
         passwordTextField.layer.cornerRadius = 5
         passwordConfirmTextField.layer.cornerRadius = 5
        registerBtn.layer.cornerRadius = 5
        cancelButton.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
     func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }

    //this is getting extra calls between textfields, making it go higher on screen
    func adjustingHeight(show:Bool, notification:NSNotification) {
        
        // 1 Get notification information in an dictionary
        var userInfo = notification.userInfo!
        
        // 2 From information dictionary get keyboard’s size
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        // 3 Get the time required for keyboard pop up animation
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        // 4 Extract height of keyboard & add little space(40) between keyboard & text field. If bool is true then height is multiplied by 1 & if its false then height is multiplied by –1. This is short hand of if else statement. See complete list of short hand here.
        let changeInHeight = (keyboardFrame.height - 360) * (show ? 1 : -1)
        
        //5 Animation moving constraint at same speed of moving keyboard & change bottom constraint accordingly.
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            self.bottomConstraint.constant += changeInHeight
        })
        
    }
    
    // this function is the reason why the first option in pickerview isnt selctable-FIX IT!
    func textFieldChanged(textField: UITextField) {
        
        if emailTextField.text == "" || passwordTextField.text == "" || passwordConfirmTextField.text == "" {
            registerBtn.isEnabled = false
        } else {
            registerBtn.isEnabled = true
        }
    }
    

    
    @IBAction func register(_ sender: UIButton) {
        
        if passwordTextField.text != passwordConfirmTextField.text {
            Utility.showAlert(viewController: self, title: "Registration Error", message: "Password confirmation failed. Plase enter your password try again.")
            return
        }
        
        if !Utility.isValidEmail(emailAddress: emailTextField.text!) {
            Utility.showAlert(viewController: self, title: "Registration Error", message: "Please enter a valid email address.")
            return
        }

        spinner.startAnimating()
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        BackendlessManager.sharedInstance.registerUser(email: email, password: password,
            completion: {
                
                BackendlessManager.sharedInstance.loginUser(email: email, password: password,
                    completion: {
                    
                        self.spinner.stopAnimating()
                        
                        //heres where we load local database into backendless
                        
                        self.performSegue(withIdentifier: "gotoMenuFromRegister", sender: sender)
                    },
                    
                    error: { message in
                        
                        self.spinner.stopAnimating()
                        
                        Utility.showAlert(viewController: self, title: "Login Error", message: message)
                    })
            },
            
            error: { message in
                
                self.spinner.stopAnimating()
                
                Utility.showAlert(viewController: self, title: "Register Error", message: message)
            })
    }

    @IBAction func cancel(_ sender: UIButton) {
        
        spinner.stopAnimating()
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
