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
        test()
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
                nameEndAt = nameEndAt?.advancedBy(1)
            }
            else if ((space) != nil) {
                nameEndAt = space
            }
            else {
                continue
            }
   
            let name = line.substringToIndex(nameEndAt!).lowercaseString
            var description:String
            if ((nameEndAt) != line.endIndex) {
                description = line.substringFromIndex(nameEndAt!.advancedBy(1))
            } else {
                description = ""
            }
            
            let word = SatWord(name: name, description: description)
            allSatWord.append(word!)
        }
    }
    
    func levenshteinDistance(s1: String, s2:String)->Int {
        return s1.getLevenshtein(s2)
    }
    
    struct Match {
        var distance: Int
        var word: SatWord
    }
    
    func printMatch(match: Match) {
        print("Word: "+match.word.getName()+", Distance: "+String(match.distance))
    }
    func printMatches(matches: [Match]) {
        print("Matches:")
        for match in matches {
            print("Word: "+match.word.getName()+", Distance: "+String(match.distance))
        }
    }
    
    func test() {
        print(allSatWord[2].getName())
        print(allSatWord[2].getDescription())
        print(allSatWord[4].getName())
        print(allSatWord[4].getDescription())
        print(levenshteinDistance(allSatWord[2].getName(), s2: allSatWord[4].getName()))
        
        var w = query("apple", count: 10)
        for i in 0..<10 {
            print(w[i].getName())
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
        // Initialize match pool
        var matches = [Match]()
        for i in 0..<count {
            let word = allSatWord[i];
            let d = levenshteinDistance(q, s2: word.getName())
            let m = Match(distance: d, word: word)
            matches.append(m)
        }
        matches.sortInPlace { (m1:Match,m2:Match) -> Bool in
            m1.distance<m2.distance
        }
        printMatches(matches)
        
        // Update smallest distance
        for word in allSatWord {
            let d = levenshteinDistance(q, s2: word.getName())
            let m = Match(distance: d, word: word)
            let largestDistance = matches[count-1].distance
            
            if (m.distance<largestDistance) {
                matches[count-1] = m
                matches.sortInPlace { (m1:Match,m2:Match) -> Bool in
                    m1.distance<m2.distance
                }
            }
        }
        
        //
        var resultArray = [SatWord]();
        for match in matches {
            resultArray.append(match.word)
        }
        return resultArray
    }
    
    // Find the SatWord in database
    func getSatWord(name: String, description: String="")->SatWord {
        return SatWord(name: name, description: description)!
    }
}