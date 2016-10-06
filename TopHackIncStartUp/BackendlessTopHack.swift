//
//  BackendlessTopHack.swift
//  TopHackInc
//
//  Created by Robert Martin on 9/4/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import Foundation

// (use to be based off of BackendlessMeal) data specifically for database categories
class BackendlessTopHack: NSObject {
    
    var objectId: String?
    var name: String? //figure out what this goes to
    //no big photos
    var photoUrl: String?
    var thumbnailUrl: String?
    //var dateOrTimeFrame: Timeframe?
    
    
     //person of interest variables
     var fullName: String?
     var compName: String?
     var jobType: String?
     var networkStatus: String?
     var standoutInfo: String?
     var email: String?
     var thumbnailPic: String?
     var linkedInUser: String?
     var instagramUser: String?
     var faceBookUser: String?
     var twitterUser: String?
     
     //event variables (these are also apart of a struct)
     var EventName: String?
     var Website: String? //website URl
     var EventProgramType: String?
     var EventAreaLoc: String?
     var EventLogo: String?
     var EventDate: String?
 
 
 
    
}
