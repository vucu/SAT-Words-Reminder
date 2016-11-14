//
//  SatWord.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/10/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import Foundation

class SatWord: NSObject, NSCoding {
    var name: String
    var descriptionString: String
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let descriptionKey = "descriptionString"
    }
    
    // MARK: Initialization
    init?(name: String, description: String) {
        self.name = name
        self.descriptionString = description
        if descriptionString.isEmpty {
            self.descriptionString = ""
        }
        
        super.init()
        if name.isEmpty {
            return nil
        }
    }
    
    // MARK: Interface
    func getName()->String {
        return self.name
    }
    
    func getDescription()->String {
        return self.descriptionString
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(descriptionString, forKey: PropertyKey.descriptionKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let N = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let D = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        self.init(name: N, description: D)
    }
}