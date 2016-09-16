//
//  DatesController.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/30/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//

import Foundation

class DatesController {
    
    static let sharedController = DatesController()
    
    var dates: [String] = DateTypes.allDates.map { type in
     
        let uppercased = type.rawValue.lowercaseString
        var finishedString = ""
        
        for character in uppercased.characters {
            finishedString += "\(character)"
        }
        return finishedString
        
    }
    
}

