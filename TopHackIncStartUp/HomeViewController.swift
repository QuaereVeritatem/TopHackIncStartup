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

//problems here: edit button and swipe to delete dont work *******

import UIKit
//work on further increasing design as well..nav bar on homepage and double reload of homepage from table
//make sure to put in comments before I upload to github
//make sure indentations all matchup and are consistent
//fix bugs
class HomeViewController: UIViewController, UITableViewDataSource {
    
    var backEndlessUltraTopHack = [BackendlessTopHack]() // an array of a class
    var backEndlessUltraHackEvent = EventData.sharedInstance.besthackIncEvent //an array of hackIncEvent
    
    @IBOutlet weak var tableView: UITableView!
    
 
    @IBAction func addEvents(_ sender: UIBarButtonItem) {
    //already setup to go to next VC
    }
    
    @IBAction func editCurrentEvents(_ sender: UIBarButtonItem) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem

        //if backendless data is nil then load example data
        if Backendless.sharedInstance().persistenceService.of(BackendlessTopHack.ofClass()) == nil {
        //user not logged in (**user will always be logged in at this page!!!!!!!!!!!!!)
       // if !BackendlessManager.sharedInstance.isUserLoggedIn() {
            //load sample events into backendless
            //save each event as an event in backendless
            var index = 0
            for i in EventData.sharedInstance.besthackIncEvent {
                backEndlessUltraTopHack[index].EventName = i.name
                backEndlessUltraTopHack[index].EventProgramType = i.progType.map { $0.rawValue }
                backEndlessUltraTopHack[index].Website = i.progUrl
                backEndlessUltraTopHack[index].EventAreaLoc = i.areaLoc.map { $0.rawValue }
                backEndlessUltraTopHack[index].EventLogo = i.logo
                backEndlessUltraTopHack[index].EventDate = i.dateOrTimeFrame.map { $0.rawValue }
                
                //to store a name(email) of user
                backEndlessUltraTopHack[index].name = "default"
                
                //this is to create a unique objectID to store event in backendless with
                let uuid = NSUUID().uuidString
                backEndlessUltraTopHack[index].objectId = uuid
                //must save logo picture in backend as well
                
                //now load into backendless persistent save spot
                Backendless.sharedInstance().data.save( backEndlessUltraTopHack[index],
                                       
                                       response: { (entity: Any?) -> Void in
                                        
                                        let PersonOrEvent = entity as! BackendlessTopHack
                                        
                                        print("PersonOrEvent: \(PersonOrEvent.objectId!), PersonOrEvent: \(PersonOrEvent.name), photoUrl: \"\(PersonOrEvent.photoUrl!)")
                    },
                                       
                                       error: { (fault: Fault?) -> Void in
                                        print("PersonOrEvent failed to save: \(fault)")
                    }
                )
                
                index = index + 1
            }
            
            
            //then load backendless into currrent tableView
        }
        
        
        
        
        
        
 /*       if BackendlessManager.sharedInstance.isUserLoggedIn() {
            
            refresh(sender: self)

        } else {
            
            // Load any saved meals, otherwise load sample data. (this is important!!)
          //  if let savedMeals = loadMealsFromArchiver() {
             //   meals += savedMeals
        } else {
                // Load the sample data.
            
                //save each event as an event in backendless
                backEndlessUltraTopHack = EventData.sharedInstance.besthackIncEvent as! [BackendlessTopHack]
                // HACK: Disabled sample meal data for now!
                // loadSampleMeals()
            }
        } */
        // Add support for pull-to-refresh on the table view.(not really needed though)
        //self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func refresh(sender: AnyObject) {
        
//        //if BackendlessManager.sharedInstance.isUserLoggedIn() {
//            
//          //  BackendlessManager.sharedInstance.loadMeals(
//                
//                completion: { mealData in
//                    
//                    self.meals = mealData
//                    self.tableView.reloadData()
//                    self.refreshControl?.endRefreshing()
//                },
//                
//                error: {
//                    self.tableView.reloadData()
//                    self.refreshControl?.endRefreshing()
//            } //)
//        //}
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
     
          // if  editingStyle == .delete {
    if  (editingStyle == UITableViewCellEditingStyle.delete) {
            if BackendlessManager.sharedInstance.isUserLoggedIn() {
     
                // Find the EventData(old MealData) in the data source that we wish to delete.
                // let mealToRemove = meals[indexPath.row]
                var ETR = [HackIncStartUp]()
                let EventToRemove = ETR[indexPath.row]
     
                BackendlessManager.sharedInstance.removePersonOrEvent(personOrEventToRemove: EventToRemove,
     
                    completion: {
     
                        // It was removed from the database, now delete the row from the data source.
                        EventData.sharedInstance.besthackIncEvent.remove(at: (indexPath as NSIndexPath).row)
                        //tableView.deleteRows(at: [indexPath], with: .fade)
                        //animation looks better
                        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                        },
                    
                    error: {
                        
                        // It was NOT removed - tell the user and DON'T delete the row from the data source.
                        let alertController = UIAlertController(title: "Remove Failed",
                                                                message: "Oops! We couldn't remove your Event at this time.",
                                                                preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                ) //end of parameter

            } else{
                
                // Delete the row from the data source
                EventData.sharedInstance.besthackIncEvent.remove(at: (indexPath as NSIndexPath).row)
                
                // Save the meals.(events)
             //   saveMealsToArchiver()
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    @nonobjc func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (self.tableView.isEditing) {
            return UITableViewCellEditingStyle.delete
        }
        return UITableViewCellEditingStyle.none
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

