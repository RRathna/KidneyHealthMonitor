//
//  TestResult.swift
//  KidneyHealthMonitor_2
//
//  Created by Rathna Ramesh on 11/16/17.
//  Copyright © 2017 Rathna Ramesh. All rights reserved.
//

import UIKit
import os.log

class UserDetails : NSObject, NSCoding {
    
    //Data persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userFirstName, forKey: PropertyKey.userFirstName)
        aCoder.encode(userLastName, forKey: PropertyKey.userLastName)
        aCoder.encode(yearUserDOB, forKey: PropertyKey.yearUserDOB)
        aCoder.encode(monthUserDOB, forKey: PropertyKey.monthUserDOB)
        aCoder.encode(dateUserDOB, forKey: PropertyKey.dateUserDOB)
        aCoder.encode(userAddress, forKey: PropertyKey.userAddress)
        aCoder.encode(userOther, forKey: PropertyKey.userOther)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let first_name = aDecoder.decodeObject(forKey: PropertyKey.userFirstName) as? String
        let last_name = aDecoder.decodeObject(forKey: PropertyKey.userLastName) as? String
        let year = aDecoder.decodeObject(forKey: PropertyKey.yearUserDOB) as? String
        let month = aDecoder.decodeObject(forKey: PropertyKey.monthUserDOB) as? String
        let date = aDecoder.decodeObject(forKey: PropertyKey.dateUserDOB) as? String
        let address = aDecoder.decodeObject(forKey: PropertyKey.userAddress) as? String
        let other = aDecoder.decodeObject(forKey: PropertyKey.userOther) as? String
        
        
        
        // Must call designated initializer.
        self.init(FirstName: first_name!, LastName: last_name!, Year: year!, Month: month!, Date: date!, Address: address!, Other: other!)
        
    }
    
    

    
    init?(FirstName : String, LastName : String, Year : String, Month : String, Date : String, Address : String, Other : String) {
        
        
        // Initialize stored properties.
        self.userFirstName = FirstName
        self.userLastName = LastName
        self.yearUserDOB = Year
        self.monthUserDOB = Month
        self.dateUserDOB = Date
        self.userAddress = Address
        self.userOther = Other
        
    }
    
    
    
    //Properties of the class
    var userFirstName : String
    var userLastName : String
    var yearUserDOB : String
    var monthUserDOB : String
    var dateUserDOB : String
    var userAddress : String
    var userOther : String
    
    
    struct PropertyKey {
        static let userFirstName = "FirstName"
        static let userLastName = "LastName"
        static let yearUserDOB = "year"
        static let monthUserDOB = "month"
        static let dateUserDOB = "date"
        static let userAddress = "address"
        static let userOther = "other"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tests")
    
    
    
}

