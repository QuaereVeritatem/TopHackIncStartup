//
//  BackendlessManager.swift
//  TopHackIncStartup
//
//  Created by Robert Martin on 9/4/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import Foundation
import UIKit

// The BackendlessManager class below is using the Singleton pattern.
// A singleton class is a class which can be instantiated only once.
// In other words, only one instance of this class can ever exist.
// The benefit of a Singleton is that its state and functionality are
// easily accessible to any other object in the project.

class BackendlessManager {
    
    // This gives access to the one and only instance.
    static let sharedInstance = BackendlessManager()
    
    // This prevents others from using the default '()' initializer for this class.
    private init() {}
    
    let backendless = Backendless.sharedInstance()!
    
    let VERSION_NUM = "v1"
    let APP_ID = "C28E4E1C-8C05-7A6B-FF1F-47592CAFB000"
    let SECRET_KEY = "BBC8AC53-232B-9DAD-FFC6-20AFCF7E7D00"
    
    let EMAIL = "test@gmail.com" // Doubles as User Name
    let PASSWORD = "password"
    
    func initApp() {
        
        // First, init Backendless!
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        backendless.userService.setStayLoggedIn(true)
    }
    
    func isUserLoggedIn() -> Bool {
        
        // MARK : Problem here, 1st crashes here when logged out and starting app up
        let isValidUser = backendless.userService.isValidUserToken()
        print("The isValidUser variable is currently set to... \(isValidUser)")
        if isValidUser != nil && isValidUser != 0 {
            return true
        } else {
            return false
        }
    }

    
    func loginUser(email: String, password: String, completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        backendless.userService.login( email, password: password,
                                       
            response: { (user: BackendlessUser?) -> Void in
                print("User logged in: \(user!.objectId)")
                completion()
            },
                                       
            error: { (fault: Fault?) -> Void in
                print("User failed to login: \(fault)")
                error((fault?.message)!)
        })
    }
    
    func logoutUser(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        // First, check if the user is actually logged in.
        if  isUserLoggedIn()   {
            
            // If they are currently logged in - go ahead and log them out!
            
            backendless.userService.logout( { (user: Any!) -> Void in
                print("User logged out!")
                completion()
                },
                                            
                error: { (fault: Fault?) -> Void in
                print("User failed to log out: \(fault)")
                error((fault?.message)!)
            })
            
        } else {
            
            print("User is already logged out!");
            completion()
        }
    }
    
    func loginViaFacebook(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        backendless.userService.easyLogin(
            
            withFacebookFieldsMapping: ["email":"email"], permissions: ["email"],
            
            response: {(result : NSNumber?) -> () in
                print ("Result: \(result)")
                completion()
            },
            
            error: { (fault : Fault?) -> () in
                print("Server reported an error: \(fault)")
                error((fault?.message)!)
        })
    }
    
    func loginViaTwitter(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        backendless.userService.easyLogin(withTwitterFieldsMapping: ["email":"email"], 
                                          
            response: {(result : NSNumber?) -> () in
                print ("Result: \(result)")
                completion()
            },
                                          
            error: { (fault : Fault?) -> () in
                print("Server reported an error: \(fault)")
                error((fault?.message)!)
            })
    }
    
    func handleOpen(open url: URL, completion: @escaping () -> (), error: @escaping () -> ()) {
        
        print("handleOpen: url scheme = \(url.scheme)")
        
        let user = backendless.userService.handleOpen(url)
        
        if user != nil {
            print("handleOpen: user = \(user)")
            //make same as is user loggen in code/function
            completion()
        } else {
            error()
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        let user: BackendlessUser = BackendlessUser()
        user.email = email as NSString!
        user.password = password as NSString!
        
        backendless.userService.registering( user,
                                             
            response: { (user: BackendlessUser?) -> Void in
                                                
                print("User was registered: \(user?.objectId)")
                completion()
            },
                                             
            error: { (fault: Fault?) -> Void in
                print("User failed to register: \(fault)")
                error((fault?.message)!)
            }
        )
    }


    
    func savePhotoAndThumbnail(EventToSaveBE: BackendlessTopHack, photo: UIImage, completion: @escaping () -> (), error: @escaping () -> ()) {
        
        //
        // Upload the thumbnail image first...
        //
        
        let uuid = NSUUID().uuidString
        //print("\(uuid)")
        
        let size = photo.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
        let hasAlpha = false
        let scale: CGFloat = 0.1
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        photo.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let thumbnailImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let thumbnailData = UIImageJPEGRepresentation(thumbnailImage!, 1.0);
        
        backendless.fileService.upload(
            "photos/\(backendless.userService.currentUser.objectId!)/thumb_\(uuid).jpg",
            content: thumbnailData,
            overwrite: true,
            response: { (uploadedFile: BackendlessFile?) -> Void in
                print("Thumbnail image uploaded: \(uploadedFile?.fileURL!)")
                
                EventToSaveBE.thumbnailUrl = uploadedFile?.fileURL!
                
                //
                // Upload full size photo.
                //
                
                let fullSizeData = UIImageJPEGRepresentation(photo, 0.2);
                
                self.backendless.fileService.upload(
                    "photos/\(self.backendless.userService.currentUser.objectId!)/full_\(uuid).jpg",
                    content: fullSizeData,
                    overwrite:true,
                    response: { (uploadedFile: BackendlessFile?) -> Void in
                        print("Photo image uploaded to: \(uploadedFile?.fileURL!)")
                        
                        EventToSaveBE.photoUrl = uploadedFile?.fileURL!
                        
                        completion()
                    },
                    
                    error: { (fault: Fault?) -> Void in
                        print("Failed to save photo: \(fault)")
                        error()
                })
            },
            
            error: { (fault: Fault?) -> Void in
                print("Failed to save thumbnail: \(fault)")
                error()
        })
    }

    func saveEvent(newEventData: (BackendlessTopHack,HackIncStartUp), completion: @escaping () -> (), error: @escaping () -> ()) {
        
        //checking HackIncStartUp for objectID...that means this must be class type to write OBjectID's to
        if newEventData.0.objectId == nil {
            
            //
            // Create a newEvent along with a photo and thumbnail image.
            //
            //this will take the new event with no photo and make it default star
            if (newEventData.1.photo == nil) {
                newEventData.1.photo! = UIImage(named: "defaultLogo1")!
            }
            
            let EventToSaveBE = newEventData.0
            
            // MARK: Problem here - Crashes when new event added without a picture
            savePhotoAndThumbnail(EventToSaveBE: newEventData.0, photo: newEventData.1.photo!,
                                  
                completion: {
                                    
                    // Once we save the photo and its thumbnail - save the Event!
                    self.backendless.data.save( EventToSaveBE,
                                                                
                        response: { (entity: Any?) -> Void in
                                                                    
                            let Event = entity as! BackendlessTopHack
                                                                    
                            print("Event: \(Event.objectId!), name: \(Event.name), photoUrl: \"\(Event.photoUrl!)\"")
                                                                    
                            newEventData.0.objectId = Event.objectId
                            newEventData.0.photoUrl = Event.photoUrl
                            newEventData.0.thumbnailUrl = Event.thumbnailUrl
                                                                    
                            completion()
                        },
                                                                
                        error: { (fault: Fault?) -> Void in
                            print("Failed to save Event: \(fault)")
                            error()
                        })},
                                  
                    error: {
                        print("Failed to save photo and thumbnail!")
                        error()
            })
            
        } else if newEventData.1.replacePhoto {
            
            //
            // Update the event AND replace the existing photo and
            // thumbnail image with a new one.
            //
            
            let EventToSaveBE = newEventData.0
            
            savePhotoAndThumbnail(EventToSaveBE: EventToSaveBE, photo: newEventData.1.photo!,
                                  
                completion: {
                                    
                    let dataStore = self.backendless.persistenceService.of(newEventData.0.ofClass())
                                    
                    dataStore?.findID(newEventData.0.objectId,
                                                      
                    response: { (Event: Any?) -> Void in
                                                        
                        // We found the Event to update.
                        let Event = Event as! BackendlessTopHack
                                                        
                        // Cache old URLs for removal!
                        let oldPhotoUrl = Event.photoUrl!
                        let oldthumbnailUrl = Event.thumbnailUrl!
                        print("The oldthumbNailUrl = \(oldthumbnailUrl)")
                        
                        // Update the personOrEvent with the new data.
                        Event.name = newEventData.0.name
                        Event.photoUrl = EventToSaveBE.photoUrl
                        Event.thumbnailUrl = EventToSaveBE.thumbnailUrl
                        print("The new thumbnail, Event.thumbnailUrl = \(EventToSaveBE.thumbnailUrl)")
                        
                        // Save the updated Event.
                        self.backendless.data.save( Event,
                                                    
                        response: { (entity: Any?) -> Void in
                            
                            let Event = entity as! BackendlessTopHack
                            
                            print("Event: \(Event.objectId!), name: \(Event.name), photoUrl: \"\(Event.photoUrl!)\"")
                            
                            // Update the EventData used by the UI with the new URLS!
                            newEventData.0.photoUrl = Event.photoUrl
                            newEventData.0.thumbnailUrl = Event.thumbnailUrl
                            
                            completion()
                            
                            // Attempt to remove the old photo and thumbnail images.
                            self.removePhotoAndThumbnail(photoUrl: oldPhotoUrl, thumbnailUrl: oldthumbnailUrl, completion: {}, error: {})
                        },
                        
                        error: { (fault: Fault?) -> Void in
                            print("Failed to save Event: \(fault)")
                            error()
                        })
                    },
                    
                    error: { (fault: Fault?) -> Void in
                        print("Failed to find Event: \(fault)")
                        error()
                    })
            },
                
                error: {
                    print("Failed to save photo and thumbnail!")
                    error()
            })
            
        } else {
            
            //
            // Update the Event data but keep the existing photo and thumbnail image.
            //
            
            let dataStore = backendless.persistenceService.of(newEventData.0.ofClass())
            
            dataStore?.findID(newEventData.0.objectId,
                              
                response: { (Event: Any?) -> Void in
                                
                    // We found the Event to update.
                    let Event = Event as! BackendlessTopHack
                                
                    // Update the Event with the new data
                    Event.name = newEventData.0.name
                                
                    // Save the updated Event.
                    self.backendless.data.save( Event,
                                                            
                        response: { (entity: Any?) -> Void in
                                                                
                            let Event = entity as! BackendlessTopHack
                                                                
                            print("Event: \(Event.objectId!), name: \(Event.name), photoUrl: \"\(Event.photoUrl!)\"")
                                                                
                            completion()
                        },
                                                            
                        error: { (fault: Fault?) -> Void in
                            print("Failed to save Event: \(fault)")
                            error()
                        })
                    },
                              
                    error: { (fault: Fault?) -> Void in
                        print("Failed to find Event: \(fault)")
                        error()
                    }
            )
        }
    }

    
    
    func loadEvents(completion: @escaping ([BackendlessTopHack]) -> ()) {
        
        let dataStore = backendless.persistenceService.of(BackendlessTopHack.ofClass())
        
        let dataQuery = BackendlessDataQuery()
        // Only get the Persons/Events (personOrEvents) that belong to our logged in user!
        dataQuery.whereClause = "ownerId = '\(backendless.userService.currentUser.objectId!)'"
        
        dataStore?.find( dataQuery,
                         
            response: { (eventBEC: BackendlessCollection?) -> Void in
                            
                print("Find attempt on all Persons/Events (personOrEvents) has completed without error!")
                print("Number of Persons/Events (personOrEvents) found = \((eventBEC?.data.count)!)")
                            
                var eventData = [BackendlessTopHack]()
                            
                for event in (eventBEC?.data)! {
                                
                    let event = event as! BackendlessTopHack
                                
                    print("personOrEvent: \(event.objectId!), name: \(event.name), photoUrl: \"\(event.photoUrl!)\"")
                                
                    let newEventData = event
                                    
                    eventData.append(newEventData)
                                
                }
                            
                // Whatever person or events we found on the database - return them.
                completion(eventData)
            },
                         
            error: { (fault: Fault?) -> Void in
            print("Failed to find Person or event: \(fault)")
            }
        )
    }
    
    // MARK: prob setting up element of indexPath.row at becsthackIncevent
    func removeEvent(EventToRemove: BackendlessTopHack, completion: @escaping () -> (), error: @escaping () -> ()) {
        //dont delete something until it was removed from the database first!
       // print("Remove person or event: \(personOrEventToRemove.objectId!)")
        
        let dataStore = backendless.persistenceService.of(BackendlessTopHack.ofClass())
        
        _ = dataStore?.removeID(EventToRemove.objectId, response: { (result: NSNumber?) -> Void in
                                    
            print("One person or event has been removed: \(result)")
            completion() },
                                
            error: { (fault: Fault?) -> Void in
            print("Failed to remove person or event: \(fault)")
            error()
                
            }
        )
    }
    
    func removePhotoAndThumbnail(photoUrl: String, thumbnailUrl: String, completion: @escaping () -> (), error: @escaping () -> ()) {
        
        // Get just the file name which is everything after "/files/".
        let photoFile = photoUrl.components(separatedBy: "/files/").last

        backendless.fileService.remove( photoFile,
                                        
            response: { (result: Any!) -> () in
                print("Photo has been removed: result = \(result)")
                
                // Get just the file name which is everything after "/files/".
                let thumbnailFile = thumbnailUrl.components(separatedBy: "/files/").last
                
                self.backendless.fileService.remove( thumbnailFile,
                                                     
                    response: { (result: Any!) -> () in
                        print("Thumbnail has been removed: result = \(result)")
                        completion()
                    },
                    
                    error: { (fault : Fault?) -> () in
                        print("Failed to remove thumbnail: \(fault)")
                         error()
                    }
                )
            },
            
            error: { (fault : Fault?) -> () in
                print("Failed to remove photo: \(fault)")
                error()
            }
        )
    }
    
}
