//
//  Person.swift
//  Project10
//
//  Created by Jonathan Deguzman on 12/1/16.
//  Copyright © 2016 Jonathan Deguzman. All rights reserved.
//

import UIKit

// This is the universal base class for all Cocoa Touch classes
class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
