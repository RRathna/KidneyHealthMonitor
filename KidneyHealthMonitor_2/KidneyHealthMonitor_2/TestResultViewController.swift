//
//  ViewController.swift
//  KidneyHealthMonitor_2
//
//  Created by Rathna Ramesh on 11/15/17.
//  Copyright © 2017 Rathna Ramesh. All rights reserved.
//

import UIKit

class TestResultViewController: UIViewController {
    
    
    @IBOutlet weak var detailedViewName: UILabel!
    
    @IBOutlet weak var detailedViewDate: UILabel!
    
    @IBOutlet weak var detailedViewResult: UILabel!
    
    @IBOutlet weak var detailedViewPhoto: UIImageView!
    
    
    
    var testResultToDisplay : TestResult?
    
    func AssignDataToView() {
        
        if let testResult = testResultToDisplay {
            detailedViewResult.text = "Result : " + String(describing: testResult.Result)
            detailedViewPhoto.image = testResult.photo
            detailedViewDate.text = "Date : " + String(describing: testResult.date)
            detailedViewName.text = "Name : " + "UserName" //read from file
            
        }
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        AssignDataToView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

