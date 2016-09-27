//
//  ViewController.swift
//  //TopHackIncStartUp
//
//  Created by Robert Martin on 9/4/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//TableView and custom TableviewCell Demo

//TechCommunity tracker.. include website clickable link and date for events (or say year round)
//Top Hackathons,Incubators,accelerators,bootcamps that Texas programmers should know about

import UIKit
//homepage label needed..work on further increasing design as well
//make sure to put in comments before I upload to github
class HomeViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    struct hackIncStartUp {
        
        var progName: String
        var progUrl: String
        var progType: String      // this should be an enum type NOT a string
        var areaLoc: String          // this should be an enum type NOT a string
        var logo: String
        var rankings: Int
    }

    let bestHackIncStartUp = [
        hackIncStartUp(progName: "AngelHack", progUrl: "angelhack.com", progType: "hackathon", areaLoc: "Worldwide", logo: "angelHack", rankings: 7),
        hackIncStartUp(progName: "StartUpWeekend", progUrl: "StartUpWeekend.org", progType: "hackathon", areaLoc: "Worldwide", logo: "startUpWeekend", rankings: 5),
        hackIncStartUp(progName: "TechStars", progUrl: "techStars.com", progType: "accelerator", areaLoc: "Nationwide", logo: "techStars", rankings: 3),
        hackIncStartUp(progName: "TechWildCatters", progUrl: "techwildcatters.com", progType: "accelerator", areaLoc: "Dallas", logo: "techWildcatters", rankings: 4),
        hackIncStartUp(progName: "HealthWildcatters", progUrl: "healthwildcatters.com", progType: "accelerator", areaLoc: "Dallas", logo: "healthWildcatters1", rankings: 9),
        hackIncStartUp(progName: "AngelPad", progUrl: "angelpad.com", progType: "accelerator", areaLoc: "San Fran/NYC", logo: "angelPad", rankings: 2),
        hackIncStartUp(progName: "IronYard", progUrl: "theironYard.com", progType: "bootcamp", areaLoc: "Nationwide", logo: "ironYard", rankings: 6),
        hackIncStartUp(progName: "Capital Factory", progUrl: "capitalfactory.com", progType: "accelerator", areaLoc: "Austin", logo: "capitalFactory", rankings: 8),
        hackIncStartUp(progName: "Y Combinator", progUrl: "ycombinator.com", progType: "accelerator", areaLoc: "Mountainview", logo: "yCombinator", rankings: 1)
    ]

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
        cell.nameLabel.text = bestHackIncStartUp[(indexPath as NSIndexPath).row].progName
        cell.urlLabel.text = bestHackIncStartUp[(indexPath as NSIndexPath).row].progUrl
        cell.progType.text = bestHackIncStartUp[(indexPath as NSIndexPath).row].progType
        cell.locationLabel.text = bestHackIncStartUp[(indexPath as NSIndexPath).row].areaLoc
        cell.rankingLabel.text = String(bestHackIncStartUp[(indexPath as NSIndexPath).row].rankings)
        cell.IncAccHackPic.image = UIImage(named: bestHackIncStartUp[(indexPath as NSIndexPath).row].logo)
        return cell
    }


}

