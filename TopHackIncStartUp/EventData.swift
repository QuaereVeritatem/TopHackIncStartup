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


enum ProgTypes {
    case accelerator(String)
    case hackathon(String)
    case bootcamp(String)
    case incubator(String)
    case startUpPitch(String)
    case networking(String)
    
}

enum AreaLoc {
    case Worldwide(String)
    case Dallas(String)
    case Nationwide(String)
    case Austin(String)
    case Mountainview(String)
    case SanFran_NYC(String)
    case NYC(String)
    
}

enum TimeFrame {
    case yearly(String)
    case monthly(String)
    case weekly(String)
    case January(String)
    case February(String)
    case March(String)
    case April(String)
    case May(String)
    case June(String)
    case July(String)
    case August(String)
    case September(String)
    case October(String)
    case November(String)
    case December(String)
}
    
    var progTypesArray: [String] = ["accelerator", "hackathon", "bootcamp", "incubator", "startUpPitch", "networking"]
    
    var areaLocArray: [String] = ["Worldwide", "Dallas", "Nationwide", "Austin", "Mountainview", "SanFran_NYC", "NYC"]
    
    var timeFrameArray: [String] = ["Yearly", "Monthly", "Weekly", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]


    var testEvent: hackIncEvent = hackIncEvent(name: "", progUrl: "", progType: ProgTypes.hackathon("hackathon"), areaLoc: AreaLoc.Worldwide("Worldwide"), logo: "", dateOrTimeFrame: TimeFrame.monthly("Monthly"))

var besthackIncEvent = [
    hackIncEvent(name: "AngelHack", progUrl: "http://angelhack.com", progType: ProgTypes.hackathon("hackathon"), areaLoc: AreaLoc.Worldwide("Worldwide"), logo: "angelHack", dateOrTimeFrame: TimeFrame.monthly("Monthly")),
    hackIncEvent(name: "StartUpWeekend", progUrl: "https://StartUpWeekend.org", progType: ProgTypes.hackathon("hackathon"), areaLoc: AreaLoc.Worldwide("Worldwide"), logo: "startUpWeekend", dateOrTimeFrame: TimeFrame.monthly("Monthly")),
    hackIncEvent(name: "TechStars", progUrl: "http://techStars.com", progType: ProgTypes.accelerator("accelerator"), areaLoc: AreaLoc.Worldwide("Worldwide"), logo: "techStars", dateOrTimeFrame: TimeFrame.monthly("Monthly")),
    hackIncEvent(name: "TechWildCatters", progUrl: "http://techwildcatters.com", progType: ProgTypes.accelerator("accelerator"), areaLoc: AreaLoc.Dallas("Dallas"), logo: "techWildcatters", dateOrTimeFrame: TimeFrame.monthly("Monthly")),
    hackIncEvent(name: "HealthWildcatters", progUrl: "http://healthwildcatters.com", progType: ProgTypes.accelerator("accelerator"), areaLoc: AreaLoc.Dallas("Dallas"), logo: "healthWildcatters1", dateOrTimeFrame: TimeFrame.monthly("Monthly")),
    hackIncEvent(name: "AngelPad", progUrl: "https://angelpad.org", progType: ProgTypes.accelerator("accelerator"), areaLoc: AreaLoc.SanFran_NYC("SanFran_NYC"), logo: "angelPad", dateOrTimeFrame: TimeFrame.yearly("Yearly")),
    hackIncEvent(name: "IronYard", progUrl: "https://theironYard.com", progType: ProgTypes.bootcamp("bootcamp"), areaLoc: AreaLoc.Nationwide("Nationwide"), logo: "ironYard", dateOrTimeFrame: TimeFrame.monthly("Monthly")),
    hackIncEvent(name: "Capital Factory", progUrl: "https://capitalfactory.com", progType: ProgTypes.accelerator("accelerator"), areaLoc: AreaLoc.Austin("Austin"), logo: "capitalFactory", dateOrTimeFrame: TimeFrame.monthly("Monthly")),
    hackIncEvent(name: "Y Combinator", progUrl: "https://ycombinator.com", progType: ProgTypes.accelerator("accelerator"), areaLoc: AreaLoc.Mountainview("Mountainview"), logo: "yCombinator", dateOrTimeFrame: TimeFrame.yearly("Yearly"))
]

    }


