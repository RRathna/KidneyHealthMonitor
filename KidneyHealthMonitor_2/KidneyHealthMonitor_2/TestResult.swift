//
//  TestResult.swift
//  KidneyHealthMonitor_2
//
//  Created by Rathna Ramesh on 11/16/17.
//  Copyright © 2017 Rathna Ramesh. All rights reserved.
//

import UIKit
import os.log

class TestResult : NSObject, NSCoding {
    
    //Data persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(Result, forKey: PropertyKey.Result)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let result = aDecoder.decodeDouble(forKey: PropertyKey.Result)
        
        let date = aDecoder.decodeObject(forKey : PropertyKey.date) as? Date
        
        // Must call designated initializer.
        self.init(For: name, using: photo, predicted_result: result, on: date!)

    }
    
    
    //Initializers
    init?(For name: String, using photo: UIImage?, predicted_result result: Double) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || photo == nil  {
            return nil
        }
        let current_date = Date()
        // Initialize stored properties.
        self.Name = name
        self.photo = photo
        self.Result = result
        self.date = current_date
        
    }
    
    init?(For name: String, using photo: UIImage?, predicted_result result: Double, on date: Date) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || photo == nil  {
            return nil
        }
        // Initialize stored properties.
        self.Name = name
        self.photo = photo
        self.Result = result
        self.date = date
        
    }
    
    
    
    //Properties of the class
    var Name : String
    var date : Date
    var Result : Double
    var photo : UIImage?
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let Result = "Result"
        static let date = "date"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tests")

    
    
}
