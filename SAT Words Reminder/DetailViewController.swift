//
//  DetailViewController.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/12/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var wordTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    
    var satWord: SatWord?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordTextLabel.text = satWord?.getName()
        descriptionTextLabel.text = satWord?.getDescription()
        navigationItem.title = satWord?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
