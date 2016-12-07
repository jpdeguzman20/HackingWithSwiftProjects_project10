//
//  Person.swift
//  Project10
//
//  Created by Jonathan Deguzman on 12/1/16.
//  Copyright © 2016 Jonathan Deguzman. All rights reserved.
//

import UIKit

// NSObject is the universal base class for all Cocoa Touch classes. We also need NSCoding for saving data, so we must comform to what it requires us to do first.
class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
    }
    
    /// encode(aCoder:) is used to save objects of the class
    /// - Returns: nil
    /// - Parameters:
    ///   - aCoder: the NSCoder class is responsible for reading and writing the data so that it can be used by UserDefaults
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
}
