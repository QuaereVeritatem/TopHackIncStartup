//
//  Utility.swift
//  TopHackIncStartUp
//
//  Created on 9/4/16.
//

import Foundation

class Utility {
    
    // This gives access to the one and only instance.
    static let sharedInstance = Utility()
    
    // This prevents others from using the default '()' initializer for this class.
    private init() {}

    
    static func isValidEmail(emailAddress: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: emailAddress)
        
    }
    
    static func showAlert(viewController: UIViewController, title: String, message: String) {
        
        let alertController = UIAlertController(title: title,message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func delayTask(seconds: Double, task: @escaping () -> ()) {
        
        let dispatchTime = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            task()
        })
    }
  
    //we must encode and decode data before saving or loading
/*    func loadEventFromArchiver() -> [EventData.hackIncEvent]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: EventData.hackIncEvent.ArchiveURL.path) as? [EventData.hackIncEvent]
    }
    
    func saveEventToArchiver() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: EventData.hackIncEvent.ArchiveURL.path)
        
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadPersonFromArchiver() -> [MealData]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: MealData.ArchiveURL.path) as? [MealData]
    }
    
    func savePersonToArchiver() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: MealData.ArchiveURL.path)
        
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
*/
    

    
    
}
