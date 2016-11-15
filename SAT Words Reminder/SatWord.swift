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
    var typeString: String
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let typeStringKey = "typeString"
        static let descriptionStringKey = "descriptionString"
    }
    
    // MARK: Initialization
    init?(name: String, type: String?="", description: String?="") {
        self.name = name
        if (type==nil) {
            self.typeString = ""
        } else {
            self.typeString = type!
        }
        if (description==nil) {
            self.descriptionString = ""
        } else {
            self.descriptionString = description!
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
    
    func getType()->String {
        return self.typeString
    }
    
    func getDescription()->String {
        return self.descriptionString
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(typeString, forKey: PropertyKey.typeStringKey)
        aCoder.encodeObject(descriptionString, forKey: PropertyKey.descriptionStringKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let N = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let T = aDecoder.decodeObjectForKey(PropertyKey.typeStringKey) as? String
        let D = aDecoder.decodeObjectForKey(PropertyKey.descriptionStringKey) as? String
        self.init(name: N, type: T, description: D)
    }
}