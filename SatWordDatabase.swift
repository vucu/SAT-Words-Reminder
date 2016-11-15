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
            let bracket = line.rangeOfString("(")?.startIndex
            let space = line.rangeOfString(" ")?.startIndex
            let bracketEnd = line.rangeOfString(")")?.startIndex
            
            var nameEndAt = bracket
            var typeEndAt = bracketEnd
            var descBeginAt = bracket
            if ((bracket) != nil) {
                nameEndAt = bracket
                typeEndAt = bracketEnd
                descBeginAt = typeEndAt?.advancedBy(1)
                if (descBeginAt==line.endIndex) {descBeginAt=nil}
                else {descBeginAt = descBeginAt?.advancedBy(1)}
            }
            else if ((space) != nil) {
                nameEndAt = space
                typeEndAt = nil
                descBeginAt = nameEndAt?.advancedBy(1)
                if (descBeginAt==line.endIndex) {descBeginAt=nil}
                else {descBeginAt = descBeginAt?.advancedBy(1)}
            }
            else {
                continue
            }
   
            let name = line.substringToIndex(nameEndAt!).lowercaseString
            // Note: Since this is SAT Word dictionary, only add words with length long enough
            if (name.characters.count>2) {
                var type: String
                if ((typeEndAt) != nil) {
                    type = line.substringWithRange(Range<String.Index>(start: nameEndAt!.advancedBy(1),
                        end: typeEndAt!))
                } else {
                    type = ""
                }
                var description:String
                if ((descBeginAt) != nil) {
                    description = line.substringFromIndex(descBeginAt!)
                } else {
                    description = ""
                }
                
                
                let word = SatWord(name: name, type: type, description: description)
                allSatWord.append(word!)
            }
        }
    }
    
    func levenshteinDistance(s1: String, s2:String)->Int {
        return s1.getLevenshtein(s2)
    }
    
    func isExcluded(word: SatWord, exclusion: [SatWord]?=nil)->Bool {
        if (exclusion==nil) {
            return false
        }
        
        for excludedWord in exclusion! {
            if (word.getName()==excludedWord.getName()) {
                return true
            }
        }
        
        return false
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
        
    }
    
    // MARK: Interface
    static func getInstance() -> SatWordDataBase! {
        if (singletonInstance==nil) {
            singletonInstance = SatWordDataBase()
        }
        
        return singletonInstance
    }
    
    func query(q: String, count: Int=1, exclusion: [SatWord]=[SatWord]()) -> [SatWord]{
        // Initialize match pool
        var matches = [Match]()
        let exclusionCount = exclusion.count
        for i in 0..<count+exclusionCount {
            let word = allSatWord[i];
            if isExcluded(word, exclusion: exclusion) {continue}
            
            let d = levenshteinDistance(q, s2: word.getName())
            let m = Match(distance: d, word: word)
            matches.append(m)
        }
        matches.sortInPlace { (m1:Match,m2:Match) -> Bool in
            m1.distance<m2.distance
        }
        
        // Update smallest distance
        for word in allSatWord {
            if isExcluded(word, exclusion: exclusion) {continue}
            
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