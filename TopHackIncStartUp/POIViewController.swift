//
//  POIViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 10/2/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//
//software program to crop pics really needed so pics look clean
//problems here: edit button not working, social button links not working, bluetooth button still there

import UIKit
@IBDesignable

class POIViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
    //need tableview delegates and tableview functions

    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //makes editing possible on table view (slides screen over to show minus signs)
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }


    
    // MARK: - Navigation
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     print("numberOfRowsInSection, the count is \(PersonData.sharedInstance.arrayPersonsOfInterest.count)")
     return PersonData.sharedInstance.arrayPersonsOfInterest.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let cell = tableView.dequeueReusableCell(withIdentifier: "POICell", for: indexPath) as! POITableViewCell
     
     let row = (indexPath as NSIndexPath).row
     cell.fNameLabel.text = PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].fullName
     
     //the rest of these are optionals (check for nil)
     //program type portion of cell needs data from besthackIncEvent..data is of weird types for these 3
     if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].compName != nil {
     //this doesnt print just the string literal: find a way to pull string out of output *******
        cell.compLabel.text = String(describing: PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].compName!)
     } else {
        cell.compLabel.text = ""
     }
        
    if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].jobType != nil {
            cell.jobLabel.text = String(describing: PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].jobType!)
        }   else {
            cell.jobLabel.text = ""
        }
        
    if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].networkStatus != nil {
            cell.networkLabel.text = String(describing: PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].networkStatus!)
        }   else {
            cell.networkLabel.text = ""
        }
    
    if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].standoutInfo != nil {
            cell.goodInfoLabel.text = String(describing: PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].standoutInfo!)
        }   else {
            cell.goodInfoLabel.text = ""
        }
        
    if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].poiEmail != nil {
            cell.emailLabel.text = String(describing: PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].poiEmail!)
        }   else {
            cell.emailLabel.text = ""
        }

    if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].poiThumbnailPic != nil {
            cell.photoImage.image = UIImage(named: String(describing: PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].poiThumbnailPic!))
        }   else {
            cell.photoImage.image  = UIImage(named: "defaultLogo2")
        }
        
    if  (PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].linkedInUser != nil) || (PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].linkedInUser != "") {
            cell.linkedImage.image = UIImage(named: "linkedInLogodark")
        }

    if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].faceBookUser != nil {
            cell.facebookImage.image = UIImage(named: "facebookLogodark")
        }
        
    if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].twitterUser != nil {
            cell.twitterImage.image = UIImage(named: "twitterLogodark")
        }
        
    if  PersonData.sharedInstance.arrayPersonsOfInterest[(indexPath as NSIndexPath).row].instagramUser != nil {
            cell.instagramImage.image = UIImage(named: "instagramlogodark")
        }
        
     
     return cell
     }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            if BackendlessManager.sharedInstance.isUserLoggedIn() {
                
                // Find the EventData(old MealData) in the data source that we wish to delete.
                // let mealToRemove = meals[indexPath.row]
                var PTR = [HackIncStartUp]()
                let personToRemove = PTR[indexPath.row]
                
                BackendlessManager.sharedInstance.removePersonOrEvent(personOrEventToRemove: personToRemove,
                                                                      
                                                                      completion: {
                                                                        
                                                                        // It was removed from the database, now delete the row from the data source.
                                                                        PersonData.sharedInstance.arrayPersonsOfInterest.remove(at: (indexPath as NSIndexPath).row)
                                                                        tableView.deleteRows(at: [indexPath], with: .fade)
                    },
                                                                      
                                                                      error: {
                                                                        
                                                                        // It was NOT removed - tell the user and DON'T delete the row from the data source.
                                                                        let alertController = UIAlertController(title: "Remove Failed",
                                                                                                                message: "Oops! We couldn't remove your Contact at this time.",
                                                                                                                preferredStyle: .alert)
                                                                        
                                                                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                                                        alertController.addAction(okAction)
                                                                        
                                                                        self.present(alertController, animated: true, completion: nil)
                    }
                ) //end of parameter
                
            } else{
                
                // Delete the row from the data source
                PersonData.sharedInstance.arrayPersonsOfInterest.remove(at: (indexPath as NSIndexPath).row)
                
                // Save the meals.(contacts)
                //   saveMealsToArchiver()
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @nonobjc func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (self.tableView.isEditing) {
            return UITableViewCellEditingStyle.delete
        }
        return UITableViewCellEditingStyle.none
    }
 
    func gettingTheQuotesPart<T: Equatable>(variable: T) -> String {
        var quotePart = ""
        var fullPart = variable
        var shortPart = variable
        return quotePart
    }
    



}
