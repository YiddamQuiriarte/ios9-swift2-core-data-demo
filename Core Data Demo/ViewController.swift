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
        
        // create an app delegate variable
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        // context is a handler for us to be able to access the database. this allows us to access the CoreData database.
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // we are describing the Entity we want to insert the new user into. We are doing it for Entity Name Users. Then we tell it the context we want to insert it into, which we described previously.
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)

        // set the values of the attributes for the newUser we are wanting to set.
        newUser.setValue("Steve", forKey: "username")
        newUser.setValue("rogers123", forKey: "password")

        
        do {
            // save the context.
            try context.save()
        } catch {
            print("There was a problem")
        }
        
        // now we are requesting data from the Users Entity.
        let request = NSFetchRequest(entityName: "Users")
        
        // if we want to search for something in particular we can use predicates:
        request.predicate = NSPredicate(format: "username = %@", "Steve") // search for users where username = Steve
        
        // by default, if we do a request and get some data back it returns false for the actual data. if we want to get data back and see it, then we need to set this as false.
        request.returnsObjectsAsFaults = false
        
        do {
            // save the results of our fetch request to a variable.
            let results = try context.executeFetchRequest(request)
            print(results)
            if (results.count > 0) {
                for result in results as! [NSManagedObject] {
                    
                    // delete the object that we found.
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
                        
                    // this lets us change a value of the thing we just found and change it to something else.
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

