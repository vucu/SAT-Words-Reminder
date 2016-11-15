//
//  ViewController.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/9/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"
    
    var newSatWord: SatWord?
    var searchResults: [SatWord]?
    
    override func viewDidLoad() {
        searchResults = [SatWord]()
        
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.hidden = true
        
        // Handle the text field’s user input through delegate callbacks.
        searchTextField.delegate = self;
        
        checkValidNewSatWord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidNewSatWord() {
        // Disable the Save button if the text field is empty.
        let text = searchTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidNewSatWord()
        let db = SatWordDataBase.getInstance()
        let list = SatWordList.getInstance()
        let q = searchTextField.text!.lowercaseString
        print(q, list.list[0].getName())
        searchResults = db.query(q,count: 10,exclusion: list.list)
        print(searchResults![0].getName())
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults!.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        // Set text from the data model
        let word = searchResults![indexPath.row]
        cell.textLabel?.text = word.getName()
        cell.textLabel?.font = searchTextField.font
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        let word = searchResults![indexPath.row]
        newSatWord = word
        searchTextField.text = word.getName()
        navigationItem.title = word.getName()
        searchTextField.endEditing(true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    
    // MARK: Navigation
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender === saveButton) {
            let name = "word"
            let description = "description"
            newSatWord = SatWord(name: name, description: description)
            
            
        }
    }

    // MARK: Actions
}

