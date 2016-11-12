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
    @IBOutlet weak var someImageView: UIImageView!
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
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set someImageView to display the selected image.
        someImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender === saveButton) {
            let name = "word"
            let description = "description"
            newSatWord = SatWord(name: name, description: description)
            
            
        }
    }

    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)

    }
    
    
    @IBAction func performSearch(sender: UIButton) {
        searchResultPlaceholder.text = "placeholder"
    }
    
}

