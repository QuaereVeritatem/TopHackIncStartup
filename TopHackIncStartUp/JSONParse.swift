//
//  JSONParse.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 11/6/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//
//this class has functions to turn arrays into JSON and functions to change JSON back to arrays

import Foundation

class JSONParse {
    
    static let sharedInstance = JSONParse()
    
    
    
    //change entire array to JSON in one go
    func makeJSON(array: [BackendlessTopHack]){
        
        //this isnt working so lets try other way
      /*  let array = [ "one", "two" ]
        let data = JSONSerialization.dataWithJSONObject(array, options: nil, error: nil) */
        
        //if nil then start new else append
        //if array.objectID == nil {
         do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions.prettyPrinted)
            print("The JSONData is \(jsonData)")
            } catch {
            print(error.localizedDescription)
         }
       // } else {
            //append the arry (after updates)
            //how??
            
        //}
      
    }
    
    //change JSON back into an array
    func parseJSON(){
        
        
        
        
    }
    
}
