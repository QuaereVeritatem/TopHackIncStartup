//
//  EventData.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 10/8/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import Foundation

class EventData {
    
    static let sharedInstance = EventData()

struct hackIncEvent {
    
    var name: String //program name
    var progUrl: String? //website...should be an optional
    var progType: ProgTypes? //should be an optional
    var areaLoc: AreaLoc? //location should be optional
    var logo: String? //should be an optional in case no logo added
    var dateOrTimeFrame: TimeFrame?  //should be optional
}


    enum ProgTypes: String {
    case accelerator = "accelerator"
    case hackathon = "hackathon"
    case bootcamp = "bootcamp"
    case incubator = "incubator"
    case startUpPitch = "startUpPitch"
    case networking = "networking"
    
}

    enum AreaLoc: String {
    case Worldwide = "Worldwide"
    case Dallas = "Dallas"
    case Nationwide = "Nationwide"
    case Austin = "Austin"
    case Mountainview = "Mountainview"
    case SanFran_NYC = "SanFran_NYC"
    case NYC = "NYC"
    
}

    enum TimeFrame: String {
    case yearly = "yearly"
    case monthly = "monthly"
    case weekly = "weekly"
    case January = "January"
    case February = "February"
    case March = "March"
    case April = "April"
    case May = "May"
    case June = "June"
    case July = "July"
    case August = "August"
    case September = "September"
    case October = "October"
    case November = "November"
    case December = "December"
}
    
    var progTypesArray: [String] = ["accelerator", "hackathon", "bootcamp", "incubator", "startUpPitch", "networking"]
    
    var areaLocArray: [String] = ["Worldwide", "Dallas", "Nationwide", "Austin", "Mountainview", "SanFran_NYC", "NYC"]
    
    var timeFrameArray: [String] = ["Yearly", "Monthly", "Weekly", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]


    var testEvent: hackIncEvent = hackIncEvent(name: "", progUrl: "", progType: ProgTypes.hackathon, areaLoc: AreaLoc.Worldwide, logo: "", dateOrTimeFrame: TimeFrame.monthly)

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
]

    }


