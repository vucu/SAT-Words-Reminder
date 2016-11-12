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
    
    func count() -> Int {
        return self.list.count
    }
    
    func display(position: Int) -> String {
        var s: String
        s = self.list[position].name + ":" + self.list[position].description
        return s
    }
}