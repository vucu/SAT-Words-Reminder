//
//  SatWordList.swift
//  SAT Words Reminder
//
//  Created by CLICC User on 11/11/16.
//  Copyright © 2016 CLICC User. All rights reserved.
//

import Foundation

class SatWordList: NSObject, NSCoding {
    // MARK: Properties
    var list: [SatWord]
    static var singletonInstance: SatWordList?
    
    init(list: [SatWord]=[SatWord]()) {
        print("Create list instance")
        self.list = list
        super.init()
        SatWordList.singletonInstance = self
        print("Done creating list instance")
    }
    
    // MARK: Types
    struct PropertyKey {
        static let listKey = "list"
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("SatWordListInstances")

    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(list, forKey: PropertyKey.listKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let L = aDecoder.decodeObjectForKey(PropertyKey.listKey) as! [SatWord]
        self.init(list: L)
    }
    
    // MARK: Interface
    static func getInstance() -> SatWordList! {
        if (singletonInstance==nil) {
            singletonInstance = SatWordList()
        }
        
        return singletonInstance
    }
    
    func add(word: SatWord) {
        self.list.append(word)
    }
    
    func deleteAt(position: Int) {
        self.list.removeAtIndex(position)
    }
    
    func count() -> Int {
        return self.list.count
    }
    
    func display(position: Int) -> String {
        var s: String
        s = self.list[position].getName() + " (" + self.list[position].getType()
            + "): " + self.list[position].getDescription()
        return s
    }
}