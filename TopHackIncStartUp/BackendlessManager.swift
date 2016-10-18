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
    
    //***ALL instances of CLass personOrEvent must be changed to BackendlessTopHack [DONE]
    
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
    
/*    func isUserLoggedIn() -> Bool {
        
        let isValidUser = backendless.userService.isValidUserToken()
        
        if isValidUser != nil && isValidUser != 0 {
            return true
        } else {
            return false
        }
    }
*/
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
        if 1 == 1 /* isUserLoggedIn()  */ {
            
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

    
  /*  func registerTestUser() {
        
        let user: BackendlessUser = BackendlessUser()
        user.email = EMAIL as NSString!
        user.password = PASSWORD as NSString!
        
        backendless.userService.registering( user,
                                             
                                             response: { (user: BackendlessUser?) -> Void in
                                                
                                                print("User was registered: \(user?.objectId)")
                                                
                                                self.loginTestUser()
            },
                                             
                                             error: { (fault: Fault?) -> Void in
                                                print("User failed to register: \(fault)")
                                                
                                                print(fault?.faultCode)
                                                
                                                // If fault is for "User already exists." - go ahead and just login!
                                                if fault?.faultCode == "3033" {
                                                    self.loginTestUser()
                                                }
            }
        )
    } */
    
   /* func loginTestUser() {
        
        backendless.userService.login( self.EMAIL, password: self.PASSWORD,
                                       
                                       response: { (user: BackendlessUser?) -> Void in
                                        print("User logged in: \(user!.objectId)")
            },
                                       
                                       error: { (fault: Fault?) -> Void in
                                        print("User failed to login: \(fault)")
            }
        )
    }
    */
    //************************** get rid of all personOrEvent refernces and data *****************
    
    func saveTestData() {
        
        let newPersonOrEventBE = BackendlessTopHack()
        newPersonOrEventBE.name = "Test Name #1"
        newPersonOrEventBE.photoUrl = "https://guildsa.org/wp-content/uploads/2016/09/personOrEvent1.png"
        
        backendless.data.save( newPersonOrEventBE,
                               
                               response: { (entity: Any?) -> Void in
                                
                                let PersonOrEvent = entity as! BackendlessTopHack
                                
                                print("PersonOrEvent: \(PersonOrEvent.objectId!), PersonOrEvent: \(PersonOrEvent.name), photoUrl: \"\(PersonOrEvent.photoUrl!)")
            },
                               
                               error: { (fault: Fault?) -> Void in
                                print("PersonOrEvent failed to save: \(fault)")
            }
        )
    }
    
    func loadTestData() {
        
        let dataStore = backendless.persistenceService.of(BackendlessTopHack.ofClass())
        
        dataStore?.find(
            
            { (PersonOrEventBEC: BackendlessCollection?) -> Void in
                
                print("Find attempt on all personOrEvents has completed without error!")
                print("Number of personOrEvents found = \((PersonOrEventBEC?.data.count)!)")
                
                for personOrEvent in (PersonOrEventBEC?.data)! {
                    
                    let personOrEvent = personOrEvent as! BackendlessTopHack
                    
                    print("personOrEvent: \(personOrEvent.objectId!), name: \(personOrEvent.name), photoUrl: \"\(personOrEvent.photoUrl!)\"")
                }
            },
            
            error: { (fault: Fault?) -> Void in
                print("Failed to find personOrEvents: \(fault)")
            }
        )
    }
    
    func savePhotoAndThumbnail(personOrEventToSaveBE: BackendlessTopHack, photo: UIImage, completion: @escaping () -> (), error: @escaping () -> ()) {
        
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
                
                personOrEventToSaveBE.thumbnailUrl = uploadedFile?.fileURL!
                
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
                        
                        personOrEventToSaveBE.photoUrl = uploadedFile?.fileURL!
                        
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
    
   func savePersonOrEvent(newPersonOrEventData: HackIncStartUp, completion: @escaping () -> (), error: @escaping () -> ()) {
        
        if newPersonOrEventData.objectId == nil {
            
            //
            // Create a new personOrEvent along with a photo and thumbnail image.
            //
            
            let personOrEventToSaveBE = BackendlessTopHack()
            personOrEventToSaveBE.name = newPersonOrEventData.name
            
            savePhotoAndThumbnail(personOrEventToSaveBE: personOrEventToSaveBE, photo: newPersonOrEventData.photo!,
                                                       
               completion: {
                
                    // Once we save the photo and its thumbnail - save the personOrEvent!
                    self.backendless.data.save( personOrEventToSaveBE,

                       response: { (entity: Any?) -> Void in

                            let personOrEvent = entity as! BackendlessTopHack

                            print("personOrEvent: \(personOrEvent.objectId!), name: \(personOrEvent.name), photoUrl: \"\(personOrEvent.photoUrl!)\"")

                            newPersonOrEventData.objectId = personOrEvent.objectId
                            newPersonOrEventData.photoUrl = personOrEvent.photoUrl
                            newPersonOrEventData.thumbnailUrl = personOrEvent.thumbnailUrl
                        
                            completion()
                        },
                       
                       error: { (fault: Fault?) -> Void in
                            print("Failed to save personOrEvent: \(fault)")
                            error()
                    })
                },
               
                error: {
                    print("Failed to save photo and thumbnail!")
                    error()
                })

        } else if newPersonOrEventData.replacePhoto {
            
            //
            // Update the person or event AND replace the existing photo and 
            // thumbnail image with a new one.
            //
            
            let personOrEventToSaveBE = BackendlessTopHack()
            
            savePhotoAndThumbnail(personOrEventToSaveBE: personOrEventToSaveBE, photo: newPersonOrEventData.photo!,
                                                       
               completion: {

                    let dataStore = self.backendless.persistenceService.of(BackendlessTopHack.ofClass())

                    dataStore?.findID(newPersonOrEventData.objectId,
                                      
                        response: { (personOrEvent: Any?) -> Void in
                            
                            // We found the personOrEvent to update.
                            let personOrEvent = personOrEvent as! BackendlessTopHack
                            
                            // Cache old URLs for removal!
                            let oldPhotoUrl = personOrEvent.photoUrl!
                            let oldthumbnailUrl = personOrEvent.thumbnailUrl!
                            
                            // Update the personOrEvent with the new data.
                            personOrEvent.name = newPersonOrEventData.name
                            personOrEvent.photoUrl = personOrEventToSaveBE.photoUrl
                            personOrEvent.thumbnailUrl = personOrEventToSaveBE.thumbnailUrl
                            
                            // Save the updated personOrEvent.
                            self.backendless.data.save( personOrEvent,
                                                   
                                response: { (entity: Any?) -> Void in
                                    
                                    let personOrEvent = entity as! BackendlessTopHack
                                    
                                    print("personOrEvent: \(personOrEvent.objectId!), name: \(personOrEvent.name), photoUrl: \"\(personOrEvent.photoUrl!)\"")
                                    
                                    // Update the personOrEventData used by the UI with the new URLS!
                                    newPersonOrEventData.photoUrl = personOrEvent.photoUrl
                                    newPersonOrEventData.thumbnailUrl = personOrEvent.thumbnailUrl
                                    
                                    completion()
                                    
                                    // Attempt to remove the old photo and thumbnail images.
                                    self.removePhotoAndThumbnail(photoUrl: oldPhotoUrl, thumbnailUrl: oldthumbnailUrl, completion: {}, error: {})
                                },
                                                   
                               error: { (fault: Fault?) -> Void in
                                    print("Failed to save personOrEvent: \(fault)")
                                    error()
                            })
                        },
                         
                        error: { (fault: Fault?) -> Void in
                            print("Failed to find personOrEvent: \(fault)")
                            error()
                        }
                    )
                },
                                                       
                error: {
                    print("Failed to save photo and thumbnail!")
                    error()
                })
            
        } else {
            
            //
            // Update the personOrEvent data but keep the existing photo and thumbnail image.
            //
            
            let dataStore = backendless.persistenceService.of(BackendlessTopHack.ofClass())

            dataStore?.findID(newPersonOrEventData.objectId,
                              
                response: { (personOrEvent: Any?) -> Void in
                    
                    // We found the personOrEvent to update.
                    let personOrEvent = personOrEvent as! BackendlessTopHack
                    
                    // Update the personOrEvent with the new data
                    personOrEvent.name = newPersonOrEventData.name
                    
                    // Save the updated personOrEvent.
                    self.backendless.data.save( personOrEvent,
                                           
                        response: { (entity: Any?) -> Void in
                            
                            let personOrEvent = entity as! BackendlessTopHack
                            
                            print("personOrEvent: \(personOrEvent.objectId!), name: \(personOrEvent.name), photoUrl: \"\(personOrEvent.photoUrl!)\"")
                            
                            completion()
                        },
                                           
                       error: { (fault: Fault?) -> Void in
                            print("Failed to save personOrEvent: \(fault)")
                            error()
                    })
                },
                 
                error: { (fault: Fault?) -> Void in
                    print("Failed to find personOrEvent: \(fault)")
                    error()
                }
            )
        }
    }
    //************* next one copy
    func saveEvent(newPersonOrEventData: HackIncStartUp, completion: @escaping () -> (), error: @escaping () -> ()) {
        
        if newPersonOrEventData.objectId == nil {
            
            //
            // Create a new personOrEvent along with a photo and thumbnail image.
            //
            
            let personOrEventToSaveBE = BackendlessTopHack()
            personOrEventToSaveBE.name = newPersonOrEventData.name
            
            savePhotoAndThumbnail(personOrEventToSaveBE: personOrEventToSaveBE, photo: newPersonOrEventData.photo!,
                                  
                                  completion: {
                                    
                                    // Once we save the photo and its thumbnail - save the personOrEvent!
                                    self.backendless.data.save( personOrEventToSaveBE,
                                                                
                                                                response: { (entity: Any?) -> Void in
                                                                    
                                                                    let personOrEvent = entity as! BackendlessTopHack
                                                                    
                                                                    print("personOrEvent: \(personOrEvent.objectId!), name: \(personOrEvent.name), photoUrl: \"\(personOrEvent.photoUrl!)\"")
                                                                    
                                                                    newPersonOrEventData.objectId = personOrEvent.objectId
                                                                    newPersonOrEventData.photoUrl = personOrEvent.photoUrl
                                                                    newPersonOrEventData.thumbnailUrl = personOrEvent.thumbnailUrl
                                                                    
                                                                    completion()
                                        },
                                                                
                                                                error: { (fault: Fault?) -> Void in
                                                                    print("Failed to save personOrEvent: \(fault)")
                                                                    error()
                                    })
                },
                                  
                                  error: {
                                    print("Failed to save photo and thumbnail!")
                                    error()
            })
            
        } else if newPersonOrEventData.replacePhoto {
            
            //
            // Update the person or event AND replace the existing photo and
            // thumbnail image with a new one.
            //
            
            let personOrEventToSaveBE = BackendlessTopHack()
            
            savePhotoAndThumbnail(personOrEventToSaveBE: personOrEventToSaveBE, photo: newPersonOrEventData.photo!,
                                  
                                  completion: {
                                    
                                    let dataStore = self.backendless.persistenceService.of(BackendlessTopHack.ofClass())
                                    
                                    dataStore?.findID(newPersonOrEventData.objectId,
                                                      
                                                      response: { (personOrEvent: Any?) -> Void in
                                                        
                                                        // We found the personOrEvent to update.
                                                        let personOrEvent = personOrEvent as! BackendlessTopHack
                                                        
                                                        // Cache old URLs for removal!
                                                        let oldPhotoUrl = personOrEvent.photoUrl!
                                                        let oldthumbnailUrl = personOrEvent.thumbnailUrl!
                                                        
                                                        // Update the personOrEvent with the new data.
                                                        personOrEvent.name = newPersonOrEventData.name
                                                        personOrEvent.photoUrl = personOrEventToSaveBE.photoUrl
                                                        personOrEvent.thumbnailUrl = personOrEventToSaveBE.thumbnailUrl
                                                        
                                                        // Save the updated personOrEvent.
                                                        self.backendless.data.save( personOrEvent,
                                                                                    
                                                                                    response: { (entity: Any?) -> Void in
                                                                                        
                                                                                        let personOrEvent = entity as! BackendlessTopHack
                                                                                        
                                                                                        print("personOrEvent: \(personOrEvent.objectId!), name: \(personOrEvent.name), photoUrl: \"\(personOrEvent.photoUrl!)\"")
                                                                                        
                                                                                        // Update the personOrEventData used by the UI with the new URLS!
                                                                                        newPersonOrEventData.photoUrl = personOrEvent.photoUrl
                                                                                        newPersonOrEventData.thumbnailUrl = personOrEvent.thumbnailUrl
                                                                                        
                                                                                        completion()
                                                                                        
                                                                                        // Attempt to remove the old photo and thumbnail images.
                                                                                        self.removePhotoAndThumbnail(photoUrl: oldPhotoUrl, thumbnailUrl: oldthumbnailUrl, completion: {}, error: {})
                                                            },
                                                                                    
                                                                                    error: { (fault: Fault?) -> Void in
                                                                                        print("Failed to save personOrEvent: \(fault)")
                                                                                        error()
                                                        })
                                        },
                                                      
                                                      error: { (fault: Fault?) -> Void in
                                                        print("Failed to find personOrEvent: \(fault)")
                                                        error()
                                        }
                                    )
                },
                                  
                                  error: {
                                    print("Failed to save photo and thumbnail!")
                                    error()
            })
            
        } else {
            
            //
            // Update the personOrEvent data but keep the existing photo and thumbnail image.
            //
            
            let dataStore = backendless.persistenceService.of(BackendlessTopHack.ofClass())
            
            dataStore?.findID(newPersonOrEventData.objectId,
                              
                              response: { (personOrEvent: Any?) -> Void in
                                
                                // We found the personOrEvent to update.
                                let personOrEvent = personOrEvent as! BackendlessTopHack
                                
                                // Update the personOrEvent with the new data
                                personOrEvent.name = newPersonOrEventData.name
                                
                                // Save the updated personOrEvent.
                                self.backendless.data.save( personOrEvent,
                                                            
                                                            response: { (entity: Any?) -> Void in
                                                                
                                                                let personOrEvent = entity as! BackendlessTopHack
                                                                
                                                                print("personOrEvent: \(personOrEvent.objectId!), name: \(personOrEvent.name), photoUrl: \"\(personOrEvent.photoUrl!)\"")
                                                                
                                                                completion()
                                    },
                                                            
                                                            error: { (fault: Fault?) -> Void in
                                                                print("Failed to save personOrEvent: \(fault)")
                                                                error()
                                })
                },
                              
                              error: { (fault: Fault?) -> Void in
                                print("Failed to find personOrEvent: \(fault)")
                                error()
                }
            )
        }
    }

    
    
    func loadPersonOrEvents(completion: @escaping ([HackIncStartUp]) -> ()) {
        
        let dataStore = backendless.persistenceService.of(BackendlessTopHack.ofClass())
        
        let dataQuery = BackendlessDataQuery()
        // Only get the Persons/Events (personOrEvents) that belong to our logged in user!
        dataQuery.whereClause = "ownerId = '\(backendless.userService.currentUser.objectId!)'"
        
        dataStore?.find( dataQuery,
                         
                         response: { (PersonOrEventBEC: BackendlessCollection?) -> Void in
                            
                            print("Find attempt on all Persons/Events (personOrEvents) has completed without error!")
                            print("Number of Persons/Events (personOrEvents) found = \((PersonOrEventBEC?.data.count)!)")
                            
                            var personOrEventData = [HackIncStartUp]()
                            
                            for personOrEvent in (PersonOrEventBEC?.data)! {
                                
                                let personOrEvent = personOrEvent as! BackendlessTopHack
                                
                                print("personOrEvent: \(personOrEvent.objectId!), name: \(personOrEvent.name), photoUrl: \"\(personOrEvent.photoUrl!)\"")
                                
                                let newPersonOrEventData = HackIncStartUp(name: personOrEvent.name!, photo: nil)
                                
                                if let newPersonOrEventData = newPersonOrEventData {
                                    
                                    newPersonOrEventData.objectId = personOrEvent.objectId
                                    newPersonOrEventData.photoUrl = personOrEvent.photoUrl
                                    newPersonOrEventData.thumbnailUrl = personOrEvent.thumbnailUrl
                                    
                                    personOrEventData.append(newPersonOrEventData)
                                }
                            }
                            
                            // Whatever person or events we found on the database - return them.
                            completion(personOrEventData)
            },
                         
                         error: { (fault: Fault?) -> Void in
                            print("Failed to find Person or event: \(fault)")
            }
        )
    }
    
    
    func removePersonOrEvent(personOrEventToRemove: HackIncStartUp, completion: @escaping () -> (), error: @escaping () -> ()) {
        //dont delete something until it was removed from the database first!
        print("Remove person or event: \(personOrEventToRemove.objectId!)")
        
        let dataStore = backendless.persistenceService.of(BackendlessTopHack.ofClass())
        
        _ = dataStore?.removeID(personOrEventToRemove.objectId, response: { (result: NSNumber?) -> Void in
                                    
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
