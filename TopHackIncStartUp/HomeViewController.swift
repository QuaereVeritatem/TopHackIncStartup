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
    
    @IBOutlet weak var myTableView: UITableView!
    
 /*
    struct hackIncEvent {
        
        var name: String //program name
        var progUrl: String? //website...should be an optional
        var progType: ProgTypes? //should be an optional
        var areaLoc: AreaLoc? //location should be optional
        var logo: String? //should be an optional in case no logo added
        var dateOrTimeFrame: TimeFrame?  //should be optional
    }
    
        
    enum ProgTypes {
        case accelerator
        case hackathon
        case bootcamp
        case incubator
        case startUpPitch
        case networking
        
    }
    
    enum AreaLoc {
        case Worldwide
        case Dallas
        case Nationwide
        case Austin
        case Mountainview
        case SanFran_NYC
        case NYC
        
    }
    
    enum TimeFrame {
        case yearly
        case monthly
        case weekly
        case specificMonth(TwelveMonths)
        case specificDate(Int, Int, Int) //implement pickerview on months that use this variable month,day,year
        
    }
    
    enum TwelveMonths {
        case January
        case February
        case March
        case April
        case May
        case June
        case July
        case August
        case September
        case October
        case November
        case December
    }
    
    
    var besthackIncEvent = [
        hackIncEvent(name: "AngelHack", progUrl: "http://angelhack.com", progType: ProgTypes.hackathon, areaLoc: AreaLoc.Worldwide, logo: "angelHack", dateOrTimeFrame: TimeFrame.monthly),
        hackIncEvent(name: "StartUpWeekend", progUrl: "https://StartUpWeekend.org", progType: ProgTypes.hackathon, areaLoc: AreaLoc.Worldwide, logo: "startUpWeekend", dateOrTimeFrame: TimeFrame.monthly),
        hackIncEvent(name: "TechStars", progUrl: "http://techStars.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Worldwide, logo: "techStars", dateOrTimeFrame: TimeFrame.monthly),
        hackIncEvent(name: "TechWildCatters", progUrl: "http://techwildcatters.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Dallas, logo: "techWildcatters", dateOrTimeFrame: TimeFrame.monthly),
        hackIncEvent(name: "HealthWildcatters", progUrl: "http://healthwildcatters.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Dallas, logo: "healthWildcatters1", dateOrTimeFrame: TimeFrame.monthly),
        hackIncEvent(name: "AngelPad", progUrl: "https://angelpad.org", progType: ProgTypes.accelerator, areaLoc: AreaLoc.SanFran_NYC, logo: "angelPad", dateOrTimeFrame: TimeFrame.yearly),
        hackIncEvent(name: "IronYard", progUrl: "https://theironYard.com", progType: ProgTypes.bootcamp, areaLoc: AreaLoc.Nationwide, logo: "ironYard", dateOrTimeFrame: TimeFrame.monthly),
        hackIncEvent(name: "Capital Factory", progUrl: "https://capitalfactory.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Austin, logo: "capitalFactory", dateOrTimeFrame: TimeFrame.monthly),
        hackIncEvent(name: "Y Combinator", progUrl: "https://ycombinator.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Mountainview, logo: "yCombinator", dateOrTimeFrame: TimeFrame.yearly)
    ] */
    
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
        return EventData.sharedInstance.besthackIncEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*safely unwrap optionals
        //fetch an example optional string
           let optionalString = fetchOptionalString()
        
        // now unwrap it
           if let unwrapped = optionalString {
               print(unwrapped)
        }   */
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TopCell
        
        let row = (indexPath as NSIndexPath).row
        
        cell.nameLabel.text = EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].name
        
        //the rest of these are optionals (check for nil)
        if  EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].progType != nil {
            cell.progType.text = String(describing: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].progType)
        } else {
            cell.progType.text = ""
        }
        
        if  EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].areaLoc != nil {
        cell.locationLabel.text = String(describing: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].areaLoc)
        } else {
            cell.locationLabel.text = ""
        }
        
        if  EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].dateOrTimeFrame != nil {
        cell.rankingLabel.text = String(describing: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].dateOrTimeFrame)
        } else {
            cell.rankingLabel.text = ""
        }
        
        if EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].logo != nil {
        cell.IncAccHackPic.image = UIImage(named: EventData.sharedInstance.besthackIncEvent[(indexPath as NSIndexPath).row].logo!)
        } else {
            cell.IncAccHackPic.image = UIImage(named: "defaultLogo1")
        }
        
        var shortUrl: String = ""
        //test for nil
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


}

