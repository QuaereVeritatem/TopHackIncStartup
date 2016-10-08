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
