//
//  POIViewController.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 10/2/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//
//software program to crop pics really needed so pics look clean

import UIKit

class POIViewController: UIViewController {
    
    struct personsOfInterest {
        var fullName: String
        var compName: String?
        var jobType: JobTypes?
        var networkStatus: NetworkStatus?
        var standoutInfo:String?
        var poiEmail: String? //website URL
        var poiThumbnailPic: String?
        var linkedInUser: String?
        var twitterUser: String?
        var faceBookUser: String?
        var instagramUser: String?
        
    }

    enum JobTypes {
        case Developer
        case Designer
        case Investor
        case Management
        case Entrepreneur
        case other
    }
    
    enum NetworkStatus {
        case ImportantPerson
        case Connection
        case MightNeedThereHelp
        case WouldLikeToWorkWith
        case VIP
    }
    
    var arrayPersonsOfInterest = [
        personsOfInterest(fullName: "Robert Martin", compName: "Texas Instruments", jobType: JobTypes.Developer, networkStatus: NetworkStatus.MightNeedThereHelp, standoutInfo: "Very Imaginative", poiEmail: "I am getting a new one@gmail.com", poiThumbnailPic: "Not Tom", linkedInUser: "", twitterUser: "", faceBookUser: "",instagramUser: "" )]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
