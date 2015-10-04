//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Jason Shultz on 10/3/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
//        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
//        
//        newUser.setValue("Steve", forKey: "username")
//        newUser.setValue("rogers123", forKey: "password")
//
//        
//        do {
//            try context.save()
//        } catch {
//            print("There was a problem")
//        }
        
        let request = NSFetchRequest(entityName: "Users")
        
//        request.predicate = NSPredicate(format: "username = %@", "Steve") // Search Core Date for this
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.executeFetchRequest(request)
            print(results)
            if (results.count > 0) {
                for result in results as! [NSManagedObject] {
                    
//                    context.deleteObject(result)
                      do {
                            try context.save() // you have to save after deleting (or anything else) otherwise it won't stick.
                      } catch {
                            print("something went wrong")
                      }
                    
                    if let username = result.valueForKey("username") as? String { // cast username as String so we can use it.
                        print(username)
                    }
                    
                    if let password = result.valueForKey("password") as? String { // cast password as String so we can use it.
                        print(password)
                        
//                        result.setValue("something", forKey: "password") // change the password to something else.
                        
//                        do {
//                            try context.save()
//                        } catch {
//                            print("something went wrong")
//                        }
                    }
                    
                    

                }
            }
        } catch {
            print("There was a problem")
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

