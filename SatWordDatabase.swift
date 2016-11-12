//
//  SatWordDatabase.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/11/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import Foundation

class SatWordDataBase {
    // MARK: Properties

    init() {
        
    }
    
    // MARK: Interface
    func query(q: String, count: Int) -> [SatWord]{
        // Note: For now, just return fake SatWord
        var fakeArray = [SatWord]();
        for i in 0..<count {
            let fakeWord = SatWord(name: q+String(i), description: q+String(i))
            fakeArray.append(fakeWord!)
        }
        return fakeArray
    }
}