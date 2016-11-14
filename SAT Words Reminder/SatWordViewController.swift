//
//  SatWordViewController.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/11/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import UIKit

class SatWordViewController: UITableViewController {
    // MARK: Properties
    var satWordList: SatWordList?
    
    func loadSampleSatWords() {
        // For now, create fake words
        satWordList = SatWordList()
        let fake1 = SatWord(name: "Fake 1", description: "This is a fake word")
        satWordList!.add(fake1!)
        let fake2 = SatWord(name: "Fake 2", description: "This is a fake word")
        satWordList!.add(fake2!)
        let fake3 = SatWord(name: "Fake 3", description: "This is a fake word")
        satWordList!.add(fake3!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load database
        SatWordDataBase.getInstance()
        
        // Load words from disk
        if let L = loadSatWordList() {
            satWordList = L
        } else {
            loadSampleSatWords()
        }
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
        return (satWordList?.count())!
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SatWordTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SatWordTableViewCell

        // Configure the cell...
        let content = satWordList?.display(indexPath.row)
        cell.satWordTextLabel.text = content

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            satWordList?.deleteAt(indexPath.row)
            saveSatWordList()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            if let selectedCell = sender as? SatWordTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedSatWord = satWordList?.list[indexPath.row]
                detailViewController.satWord = selectedSatWord
            }
        }
        else if segue.identifier == "AddSatWords" {
            // Do nothing
        }
    }

    
    @IBAction func unwindToSatWordTableView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? SearchViewController,
            newSatWord = sourceViewController.newSatWord {
                let newIndexPath = NSIndexPath(forRow: (satWordList?.count())!, inSection: 0)
                satWordList?.add(newSatWord)
                saveSatWordList()
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }

    // MARK: NSCoding
    func saveSatWordList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(satWordList!, toFile: SatWordList.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save satWordList...")
        }
    }
    
    func loadSatWordList() -> SatWordList? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(SatWordList.ArchiveURL.path!) as? SatWordList
    }

}
