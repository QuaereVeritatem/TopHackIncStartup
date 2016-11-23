//
//  HomeViewController.swift
//  //TophackIncEvent a.k.a. TechBolt
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
    
    var backEndlessUltraTopHack: [BackendlessTopHack] = [] // an array of a class
    var BackTopHack: BackendlessTopHack = BackendlessTopHack()
    var backEndlessUltraHackEvent = EventData.sharedInstance.besthackIncEvent //an array of hackIncEvent
    //var whereThePhotosAt: HackIncStartUp = HackIncStartUp()
    
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
       // if (Backendless.sharedInstance().persistenceService.of(BackendlessTopHack.ofClass()) != nil)  {
      
        //user not logged in (**user will always be logged in at this page!!!!!!!!!!!!!)
        if BackendlessManager.sharedInstance.isUserLoggedIn() {
            if backEndlessUltraTopHack.isEmpty {
                //load sample events into backendless
                //save each event as an event in backendless
                var index = 0
                for i in backEndlessUltraHackEvent {
                
                    BackTopHack.EventName = i.name 
                    print("Event name is \(BackTopHack.EventName)")
                    BackTopHack.EventProgramType = i.progType.map { $0.rawValue }
                    BackTopHack.Website = i.progUrl
                    BackTopHack.EventAreaLoc = i.areaLoc.map { $0.rawValue }
                    BackTopHack.EventLogo = i.logo
                    BackTopHack.EventDate = i.dateOrTimeFrame.map { $0.rawValue }
                
                    //to store a name(email) of user ***change this ASAP!!!! (needs to be backendless...email)
                    BackTopHack.name = BackendlessManager.sharedInstance.EMAIL
                
                    //this is to create a unique objectID to store event in backendless with
                    let uuid = NSUUID().uuidString
                    BackTopHack.objectId = uuid
                    //must save logo picture in backend as well
                
                    backEndlessUltraTopHack.append(BackTopHack)
                    index = index + 1
                }//end of for loop
            }//end of is backendlessTopHack empty
            
            // MARK : Problem here - JSON not serializing //trying NEW WAY NOW
            
            if let json = BackTopHack.toJSON() {
                print("The json thats been serialized from BackTopHack is \(json)")
            }

            
            
            
           // JSONParse.sharedInstance.makeJSON(array: backEndlessUltraTopHack)
            //now save it to backendless persistent save spot
    /*        Backendless.sharedInstance().data.save( backEndlessUltraTopHack,
                                                    
                response: { (entity: Any?) -> Void in
                                                        
                    let Event = entity as! BackendlessTopHack
                                                        
                    print("PersonOrEvent: \(Event.objectId!), PersonOrEvent: \(Event.name), photoUrl: \"\(Event.photoUrl!)")
                },
                                                    
            error: { (fault: Fault?) -> Void in
                    print("PersonOrEvent failed to save: \(fault)")
            }
            )  */

            
        
        // MARK: Problem starts here
        
        //backendless != nil so load backendless
        BackendlessManager.sharedInstance.loadEvents(
            completion: {
                _ in Backendless.sharedInstance().persistenceService.of(BackendlessTopHack.ofClass())
                
            }
        )
        // Add support for pull-to-refresh on the table view.(not really needed though)
        //self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        }//end of is user logged in
    }//end of function
    
    func refresh(sender: AnyObject) {
        
//        //if BackendlessManager.sharedInstance.isUserLoggedIn() {
//            
//          //  BackendlessManager.sharedInstance.loadEvents(
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
       // print("numberOfRowsInSection, the count is \(EventData.sharedInstance.besthackIncEvent.count)")
        //return EventData.sharedInstance.besthackIncEvent.count
        print("numberOfRowsInSection, the new count is \(backEndlessUltraTopHack.count)")
        return EventData.sharedInstance.besthackIncEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TopCell
        
        let row = (indexPath as NSIndexPath).row
        cell.nameLabel.text = EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].name
       // cell.nameLabel.text = backEndlessUltraTopHack[(indexPath as NSIndexPath).row].EventName
        
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
        
        //loading picture/logo
       // if EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].logo != nil {
           if indexPath.row > 10 {  //gonna grab first 11 from eventdata, the other pics from loadImage
           // if backEndlessUltraTopHack[indexPath.row].thumbnailUrl != nil {
                
        // MARK:  This line needs to call HackIncStartUp for thumbnail image with name..backEndlessUltraTopHack[indexPath.row].thumbnailUrl!   (and notsaving thumbnails??)
               // loadImageFromUrl(cell: TopCell(), thumbnailUrl: backEndlessUltraTopHack[indexPath.row].thumbnailUrl!)
            loadImageFromUrl(cell: TopCell(), thumbnailUrl: "https://api.backendless.com/c28e4e1c-8c05-7a6b-ff1f-47592cafb000/v1/files/photos/046E5C21-7271-21E1-FFDB-4970E6A83B00/thumb_3FBFE09F-A344-45ED-B1D0-7F9C72868DF8.jpg")
                //print("loadImageFromUrl backendless top hack is \(backEndlessUltraTopHack[indexPath.row].thumbnailUrl!)")
        } else {
            cell.IncAccHackPic.image = UIImage(named: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].logo!)}
      /*  } else {
            cell.IncAccHackPic.image = UIImage(named: "defaultLogo1")
        } */
        
        var shortUrl: String = EventData.sharedInstance.besthackIncEvent[row].progUrl!
        // MARK : Problem website not showing is here
        //test for nil ***if NO https/http is entered by user, website isnt shown on cell-FIX!
        if EventData.sharedInstance.besthackIncEvent[row].progUrl != nil {
            let fullUrl = EventData.sharedInstance.besthackIncEvent[row].progUrl
            cell.websiteUrl = fullUrl
            // If the URL has "http://" or "https://" in it - remove it!
            if fullUrl!.lowercased().range(of: "http://") != nil {
                shortUrl = fullUrl!.replacingOccurrences(of: "http://", with: "")
            } else if fullUrl!.lowercased().range(of: "https://") != nil {
                shortUrl = fullUrl!.replacingOccurrences(of: "https://", with: "")
            }
        }   else {
            //website entered is nil
                let fullUrl = EventData.sharedInstance.besthackIncEvent[row].progUrl
            cell.websiteUrl = fullUrl
            shortUrl = ""
        }
        
        //if shortUrl == fullUrl then dont show text as a hyperlink!!!! *******
        
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
              //  var ETR = [BackendlessTopHack]()
                
                // MARK : Crashes to here when deleting events *******
               // let EventToRemove = ETR[indexPath.row]
                
                EventData.sharedInstance.besthackIncEvent.remove(at: (indexPath as NSIndexPath).row)
                tableView.deleteRows(at: [indexPath], with: .fade)

     
                //this has to be of type BackendlessTopHack(persontoremove)
        /*        BackendlessManager.sharedInstance.removeEvent(EventToRemove: EventToRemove,
     
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
                ) //end of parameter  */

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

