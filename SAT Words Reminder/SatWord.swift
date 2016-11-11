//
//  SatWord.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/10/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import Foundation

class SatWord {
    var name: String
    var description: String
    
    // MARK: Initialization
    init?(name: String, description: String) {
        self.name = name
        self.description = description
        
        if name.isEmpty {
            return nil
        }
        
        if description.isEmpty {
            self.description = ""
        }

    }
}