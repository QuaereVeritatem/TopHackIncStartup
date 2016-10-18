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
        var poiEmail: String?
        var poiThumbnailPic: String?
        var linkedInUser: String?
        var twitterUser: String?
        var faceBookUser: String?
        var instagramUser: String?
        
    }
    
    enum JobTypes: String {
        case Developer = "Developer"
        case Designer = "Designer"
        case Investor = "Investor"
        case Management = "Management"
        case Entrepreneur = "Entrepreneur"
        case other = "other"
    }
    
    enum NetworkStatus: String {
        case ImportantPerson = "Important Person"
        case Connection = "Connection"
        case MightNeedThereHelp = "Might Need There Help"
        case WouldLikeToWorkWith = "Would Like To Work With"
        case VIP = "VIP"
    }
    
    var jobTypesArray: [String] = ["Developer", "Designer", "Investor", "Management", "Entrepreneur", "other"]
    
    var networkStatusArray: [String] = ["Important Person", "Connection", "Might Need There Help", "WouldLikeToWorkWith", "VIP"]
    
    var testPerson: personsOfInterest = personsOfInterest(fullName: "", compName: nil , jobType: JobTypes.Developer, networkStatus: NetworkStatus.MightNeedThereHelp, standoutInfo: nil, poiEmail: nil, poiThumbnailPic: nil, linkedInUser: nil, twitterUser: nil, faceBookUser: nil,instagramUser: nil)
    
    var arrayPersonsOfInterest = [
        personsOfInterest(fullName: "Robert Martin", compName: "Guild of Software Architects", jobType: JobTypes.Developer, networkStatus: NetworkStatus.MightNeedThereHelp, standoutInfo: "Very Imaginative...and not Tom", poiEmail: "Use Slack", poiThumbnailPic: "Not Tom", linkedInUser: "", twitterUser: "", faceBookUser: "",instagramUser: "" )]
    
    
    
    
    
    
}
