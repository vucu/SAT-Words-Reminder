//
//  ViewController.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/9/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultPlaceholder: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var satWordList: SatWordList?
    var newSatWord: SatWord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        navigationItem.title = searchTextField.text
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
    @IBAction func performSearch(sender: UIButton) {
        searchResultPlaceholder.text = "placeholder"
    }
    
}

