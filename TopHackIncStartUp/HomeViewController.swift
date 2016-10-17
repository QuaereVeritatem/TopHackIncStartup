//
//  HomeViewController.swift
//  //TophackIncEvent
//
//  Created by Robert Martin on 9/4/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//TableView and custom TableviewCell Demo

//TechCommunity tracker.. include website clickable link and date for events (or say year round)
//Top Hackathons,Incubators,accelerators,bootcamps that programmers should know about

//**** New Name:  'TechBolt' - connecting tech proffesionals to the events you care about

import UIKit
//work on further increasing design as well..nav bar on homepage and double reload of homepage from table
//make sure to put in comments before I upload to github
//make sure indentations all matchup and are consistent
class HomeViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
 
        @IBAction func addEvents(_ sender: UIBarButtonItem) {
        //already setup to go to next VC
    }
    
    @IBAction func editCurrentEvents(_ sender: UIBarButtonItem) {
        //setup for deleting cells
    }
    
    

    //delete this 
    @IBAction func LogOutBtn(_ sender: UIButton) {
        print( "logoutBtn called!" )
        
        BackendlessManager.sharedInstance.logoutUser(
            
            completion: {
                self.performSegue(withIdentifier: "gotoLoginFromMenu", sender: sender)
                //self.dismiss(animated: true, completion: nil)
            },
            
            error: { message in
                print("User failed to log out: \(message)")
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add support for pull-to-refresh on the table view.
 //       self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection, the count is \(EventData.sharedInstance.besthackIncEvent.count)")
        return EventData.sharedInstance.besthackIncEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TopCell
        
        let row = (indexPath as NSIndexPath).row
        cell.nameLabel.text = EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].name
        
        //the rest of these are optionals (check for nil)
        //program type portion of cell needs data from besthackIncEvent..data is of weird types for these 3
        if  EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].progType != nil {
            //this doesnt print just the string literal: find a way to pull string out of output
            cell.progType.text = String(describing: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].progType!)
        } else {
            cell.progType.text = ""
        }
        
        if  EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].areaLoc != nil {
        cell.locationLabel.text = String(describing: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].areaLoc!)
        } else {
            cell.locationLabel.text = ""
        }
        
        if  EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].dateOrTimeFrame != nil {
        cell.rankingLabel.text = String(describing: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].dateOrTimeFrame!) //rankingLabel is date label name
        } else {
            cell.rankingLabel.text = ""
        }
        
        if EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].logo != nil {
        cell.IncAccHackPic.image = UIImage(named: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].logo!)
        } else {
            cell.IncAccHackPic.image = UIImage(named: "defaultLogo1")
        }
        
        var shortUrl: String = ""
        //test for nil ***if now https is entered by user, website isnt shown on cell-FIX!
        if EventData.sharedInstance.besthackIncEvent[row].progUrl != nil {
            var fullUrl = EventData.sharedInstance.besthackIncEvent[row].progUrl
            cell.websiteUrl = fullUrl
            // If the URL has "http://" or "https://" in it - remove it!
            if fullUrl!.lowercased().range(of: "http://") != nil {
                shortUrl = fullUrl!.replacingOccurrences(of: "http://", with: "")
            } else if fullUrl!.lowercased().range(of: "https://") != nil {
                shortUrl = fullUrl!.replacingOccurrences(of: "https://", with: "")
            }
        }   else {
            //website entered is nil
                var fullUrl = ""
            cell.websiteUrl = fullUrl
        }
        
        
        
        cell.websiteBtn.setTitle(shortUrl, for: UIControlState())
        
        return cell
    }
    
      func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     
    
     
     // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     
     if editingStyle == .delete {
     
     if BackendlessManager.sharedInstance.isUserLoggedIn() {
     
     // Find the MealData in the data source that we wish to delete.
     let EventToRemove = EventData.sharedInstance.besthackIncEvent[indexPath.row]
     
     //BackendlessManager.sharedInstance.removeMeal(mealToRemove: EventToRemove,
     
     //completion: {
     
     // It was removed from the database, now delete the row from the data source.
     EventData.sharedInstance.besthackIncEvent.remove(at: (indexPath as NSIndexPath).row)
     tableView.deleteRows(at: [indexPath], with: .fade)
        }
        }
    }
    
    func loadImageFromUrl(cell: TopCell, thumbnailUrl: String) {
        
        let url = URL(string: thumbnailUrl)!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    let data = try Data(contentsOf: url, options: [])
                    
                    DispatchQueue.main.async {
                        
                        // We got the image data! Use it to create a UIImage for our cell's
                        // UIImageView. Then, stop the activity spinner.
                        cell.IncAccHackPic.image = UIImage(data: data)
                        //cell.activityIndicator.stopAnimating()
                    }
                    
                } catch {
                        print("NSData Error: \(error)")
                }
                
            } else {
                    print("NSURLSession Error: \(error)")
            }
        })
        
        task.resume()
    }
    
    //generic function that can compare two values regardless of type!
    func areValuesEqual<T: Equatable>(firstValue: T, secondValue: T) -> Bool {
        return firstValue == secondValue
    }
    
    //this function will iterate through an array and find and return the element equal to the second value
    func compareAllValuesInArray<T: Equatable>(firstValue: [T], secondValue: T) -> String {

        for i in firstValue {
            if secondValue == i {
                return i as! String
            }
        }
        return "no elements are equal to the second Value"
    }
    
    //this variable gets the quotes part of the EventData.sharedInstance.besthackIncEvent variable
    func gettingTheQuotesPart<T: Equatable>(variable: T) -> String {
        var quotePart = ""
        var fullPart = variable
        return quotePart
    }


}

