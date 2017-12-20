//
//  EditUserDetails.swift
//  KidneyHealthMonitor
//
//  Created by Rathna Ramesh on 11/2/17.
//  Copyright © 2017 Rathna Ramesh. All rights reserved.
//

import Foundation
import UIKit
import os.log

class EditUserDetails: UIViewController, UITextFieldDelegate {
    
    //constants and variables for userdetails
    var userDetails : UserDetails?
 
    
    //outlets from the view


    

    
    @IBOutlet weak var firstNameTextField: UITextField!

    @IBOutlet weak var lastNameTextField: UITextField!
    

    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var monthTextField: UITextField!
    

    @IBOutlet weak var dateTextField: UITextField!
    

    @IBOutlet weak var addressTextField: UITextField!
    

    @IBOutlet weak var otherTextField: UITextField!
    

    
    @IBAction func SaveChangesToUserDetails(_ sender: UIButton) {
        updateUserDetails()
    }
    
    func readUserDetailsFromFile() {
        userDetails = loadUserDetails()
    }
    
    private func loadUserDetails() -> UserDetails?  {
            return NSKeyedUnarchiver.unarchiveObject(withFile: UserDetails.ArchiveURL.path) as? UserDetails
        }

    
    //update userDetails
    private func updateUserDetails() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(UserDetails.ArchiveURL.path, toFile: UserDetails.ArchiveURL.path)
        }
    
    //to display the current values
    func displayCurrentDetails() {
        firstNameTextField.text! = (userDetails?.userFirstName)!
        lastNameTextField.text = userDetails?.userLastName
        yearTextField.text = userDetails?.yearUserDOB
        monthTextField.text = userDetails?.monthUserDOB
        dateTextField.text = userDetails?.dateUserDOB
        addressTextField.text = userDetails?.userAddress
        otherTextField.text = userDetails?.userOther
        
    }
    func handleTextFieldDelegates() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        yearTextField.delegate = self
        monthTextField.delegate = self
        dateTextField.delegate = self
        addressTextField.delegate = self
        otherTextField.delegate = self
    }
    //function to close keypad when done is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //App opening page
        readUserDetailsFromFile()
        if userDetails != nil {
            self.displayCurrentDetails()
            
        }
        handleTextFieldDelegates()
        
        
    }
    
}

