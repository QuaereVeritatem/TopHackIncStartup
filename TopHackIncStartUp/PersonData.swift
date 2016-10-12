//
//  PersonData.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 10/11/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import Foundation

class PersonData {
    
    static let sharedInstance = PersonData()
    
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
        case Developer(String)
        case Designer(String)
        case Investor(String)
        case Management(String)
        case Entrepreneur(String)
        case other(String)
    }
    
    enum NetworkStatus {
        case ImportantPerson(String)
        case Connection(String)
        case MightNeedThereHelp(String)
        case WouldLikeToWorkWith(String)
        case VIP(String)
    }
    
    var arrayPersonsOfInterest = [
        personsOfInterest(fullName: "Robert Martin", compName: "Texas Instruments", jobType: JobTypes.,"Developer", networkStatus: NetworkStatus.MightNeedThereHelp, standoutInfo: "Very Imaginative", poiEmail: "I am getting a new one@gmail.com", poiThumbnailPic: "Not Tom", linkedInUser: "", twitterUser: "", faceBookUser: "",instagramUser: "" )]
    
    
    
    
    
    
}
