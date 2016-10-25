//
//  HackIncStartUpeal.swift
//  TopHackIncStartup
//
//  Created by Robert Martin on 9/4/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

//This is class is equivalent to Meal (classifications for user-side stuff)
//data for EventsVC and POIVC
class HackIncStartUp: NSObject, NSCoding {
    
    // MARK: Common Properties Shared by Archiver and Backendless
    
        var name: String
        var progUrl: String? //full website address
       // var progType:
       // var areaLoc: HomeViewController.hackIncStartUp.AreaLoc
        var logo: String? // an image here but an url string in BackendlessTopHack
        //var dateOrTimeFrame: TimeFrame
    
    // MARK: Archiver Only Properties
    
    var photo: UIImage?
    
    // MARK: Backendless Only Properties
    
    var objectId: String?
    var photoUrl: String?
    var thumbnailUrl: String?
    
    var replacePhoto: Bool = false
    
    // MARK: Archiving Paths
    //a persistent path on the file system where data will be saved and loaded..
    //access the path using the syntax Meal.ArchiveURL.path!(when accessed outside the class)
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //string literal said "meals" up to recently 10-24
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    //constants marked with static keyword apply to the class instead of an instance of the class.
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        //static let ratingKey = "rating"
    }
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?) {
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        
        super.init()
        
        
        // Initialization should fail if there is no name.
        if name.isEmpty  {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    //The encodeWithCoder(_:) method prepares the class’s information to be archived, and the initializer unarchives the data when the class is created.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        
        
        // Must call designated initializer.
        self.init(name: name, photo: photo)
    }
}
