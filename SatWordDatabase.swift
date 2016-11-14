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
    var allSatWord: [SatWord]
    static var singletonInstance: SatWordDataBase?

    init() {
        print("Create database instance...")
        self.allSatWord = [SatWord]()
        load()
        print("Done creating database instance!")
    }
    
    // MARK: Implementation
    func fopen() -> [String] {
        let NAME = "dictionary"
        let EXT = "csv"
        
        var contentString = [String]()
        do {
            if let path = NSBundle.mainBundle().pathForResource(NAME, ofType: EXT){
                let data = try String(contentsOfFile:path, encoding: NSMacOSRomanStringEncoding)
                
                contentString = data.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
            }
        } catch let err as NSError {
            //do sth with Error
            print(err)
        }
        return contentString;
    }
    
    func load() {
        let fileContent = fopen()
        for line in fileContent {
            let bracket = line.rangeOfString(")")?.startIndex
            let space = line.rangeOfString(" ")?.startIndex
            var nameEndAt = bracket
            if ((bracket) != nil) {
                nameEndAt = bracket
            }
            else if ((space) != nil) {
                nameEndAt = space
            }
            else {
                continue
            }
   
            let name = line.substringToIndex(nameEndAt!)
            let description = line.substringFromIndex(nameEndAt!.advancedBy(1))
            let word = SatWord(name: name, description: description)
            allSatWord.append(word!)
        }
    }
    
    // MARK: Interface
    static func getInstance() -> SatWordDataBase! {
        if (singletonInstance==nil) {
            singletonInstance = SatWordDataBase()
        }
        
        return singletonInstance
    }
    
    func query(q: String, count: Int=1, exclusion: [SatWord]?=nil) -> [SatWord]{
        // Note: For now, just return fake SatWord
        var fakeArray = [SatWord]();
        for i in 0..<count {
            let fakeWord = SatWord(name: q+String(i), description: q+String(i))
            fakeArray.append(fakeWord!)
        }
        return fakeArray
    }
    
    // Find the SatWord in database
    func getSatWord(name: String, description: String="")->SatWord {
        return SatWord(name: name, description: description)!
    }
}