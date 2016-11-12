//
//  SatWordList.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/11/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import Foundation

class SatWordList {
    // MARK: Properties
    var list: [SatWord]
    
    init() {
        self.list = [SatWord]()
    }
    
    // MARK: Interface
    func add(word: SatWord) {
        self.list.append(word)
    }
    
    func delete(position: Int) {
        self.list.removeAtIndex(position)
    }
}