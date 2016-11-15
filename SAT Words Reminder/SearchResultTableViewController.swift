//
//  SearchResultTableViewController.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/15/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    // MARK: Properties
    var searchResults: [SatWord]?
    
    
    func loadSampleResults() {
        searchResults = [SatWord]()
        let emptySatWord = SatWord(name: "empty")
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
        searchResults?.append(emptySatWord!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleResults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SearchResultTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SearchResultTableViewCell
        
        // Fetches the appropriate search result.
        let word = searchResults![indexPath.row]
        
        cell.resultLabel.text = word.getName()
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
