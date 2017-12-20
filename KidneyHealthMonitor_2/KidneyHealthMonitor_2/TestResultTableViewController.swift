//
//  TestResultTableViewController.swift
//  KidneyHealthMonitor_2
//
//  Created by Rathna Ramesh on 11/16/17.
//  Copyright © 2017 Rathna Ramesh. All rights reserved.
//

import UIKit
import os.log

class TestResultTableViewController: UITableViewController {
    
    //properties
    
    var PreviousTestResults = [TestResult]()
    
    private func loadSampleTest() {
        let photo = UIImage(named: "Image_sample")
        
        guard let sampleTestResult = TestResult(For: "UserName", using: photo, predicted_result: 10.00)
            else {
                fatalError("Unable to instantiate sampleTestResult")
        }
        PreviousTestResults += [sampleTestResult]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved test, otherwise load sample data.
        if let savedTests = loadTests() {
            PreviousTestResults += savedTests
        }
        else {
            // Load the sample data.
            loadSampleTest()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PreviousTestResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TestResultTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TestResultTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TestResultTableViewCell.")
        }
        
        //fetch the right TestResult for the cell
        let prevTest = PreviousTestResults[indexPath.row]
        
        cell.dateLabel.text = String(describing: prevTest.date)
        cell.photoImageView.image = prevTest.photo
        cell.resultLabel.text = String(prevTest.Result)
        
        return cell
    }
    
    @IBAction func unwindToTestList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? photoCapture, let newTestCaptured = sourceViewController.testResultToStore {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: PreviousTestResults.count, section: 0)
            
            PreviousTestResults.append(newTestCaptured)
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            saveTests()
        }
    }
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
    
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
        PreviousTestResults.remove(at: indexPath.row)
        saveTests()
        
    //Deletes row from view
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
        
     }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddTest":
            os_log("Adding a new Test.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let TestResultDetailViewController = segue.destination as? TestResultViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCell = sender as? TestResultTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTest = PreviousTestResults[indexPath.row]
            TestResultDetailViewController.testResultToDisplay = selectedTest
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    //function to save changes to database
    private func saveTests() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(PreviousTestResults, toFile: TestResult.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    //function to load previous test data from database
    
    private func loadTests() -> [TestResult]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TestResult.ArchiveURL.path) as? [TestResult]
    }

    
    
}
