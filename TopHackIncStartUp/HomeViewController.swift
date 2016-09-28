//
//  HomeViewController.swift
//  //TopHackIncStartUp
//
//  Created by Robert Martin on 9/4/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//TableView and custom TableviewCell Demo

//TechCommunity tracker.. include website clickable link and date for events (or say year round)
//Top Hackathons,Incubators,accelerators,bootcamps that programmers should know about

import UIKit
//work on further increasing design as well..nav bar on homepage and double reload of homepage from table
//make sure to put in comments before I upload to github
class HomeViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    struct hackIncStartUp {
        
        var name: String
        var progUrl: String
        var progType: ProgTypes
        var areaLoc: AreaLoc
        var logo: String
        var dateOrTimeFrame: TimeFrame
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
        case specificMonth
        case specificDate
        
    }
    

    let bestHackIncStartUp = [
        hackIncStartUp(name: "AngelHack", progUrl: "angelhack.com", progType: ProgTypes.hackathon, areaLoc: AreaLoc.Worldwide, logo: "angelHack", dateOrTimeFrame: TimeFrame.monthly),
        hackIncStartUp(name: "StartUpWeekend", progUrl: "StartUpWeekend.org", progType: ProgTypes.hackathon, areaLoc: AreaLoc.Worldwide, logo: "startUpWeekend", dateOrTimeFrame: TimeFrame.monthly),
        hackIncStartUp(name: "TechStars", progUrl: "techStars.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Nationwide, logo: "techStars", dateOrTimeFrame: TimeFrame.specificMonth),
        hackIncStartUp(name: "TechWildCatters", progUrl: "techwildcatters.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Dallas, logo: "techWildcatters", dateOrTimeFrame: TimeFrame.monthly),
        hackIncStartUp(name: "HealthWildcatters", progUrl: "healthwildcatters.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Dallas, logo: "healthWildcatters1", dateOrTimeFrame: TimeFrame.specificDate),
        hackIncStartUp(name: "AngelPad", progUrl: "angelpad.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.SanFran_NYC, logo: "angelPad", dateOrTimeFrame: TimeFrame.specificMonth),
        hackIncStartUp(name: "IronYard", progUrl: "theironYard.com", progType: ProgTypes.bootcamp, areaLoc: AreaLoc.Nationwide, logo: "ironYard", dateOrTimeFrame: TimeFrame.monthly),
        hackIncStartUp(name: "Capital Factory", progUrl: "capitalfactory.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Austin, logo: "capitalFactory", dateOrTimeFrame: TimeFrame.specificDate),
        hackIncStartUp(name: "Y Combinator", progUrl: "ycombinator.com", progType: ProgTypes.accelerator, areaLoc: AreaLoc.Mountainview, logo: "yCombinator", dateOrTimeFrame: TimeFrame.yearly)
    ]

    @IBAction func LogOutBtn(_ sender: UIButton) {
        print( "logoutBtn called!" )
        
        BackendlessManager.sharedInstance.logoutUser(
            
            completion: {
                self.performSegue(withIdentifier: "gotoLoginFromMenu", sender: sender)
            },
            
            error: { message in
                print("User failed to log out: \(message)")
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestHackIncStartUp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TopCell
        cell.nameLabel.text = bestHackIncStartUp[(indexPath as NSIndexPath).row].name
        cell.urlLabel.text = bestHackIncStartUp[(indexPath as NSIndexPath).row].progUrl
        cell.progType.text = String(describing: bestHackIncStartUp[(indexPath as NSIndexPath).row].progType)
        cell.locationLabel.text = String(describing: bestHackIncStartUp[(indexPath as NSIndexPath).row].areaLoc)
        cell.rankingLabel.text = String(describing: bestHackIncStartUp[(indexPath as NSIndexPath).row].dateOrTimeFrame)
        cell.IncAccHackPic.image = UIImage(named: bestHackIncStartUp[(indexPath as NSIndexPath).row].logo)
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


}

