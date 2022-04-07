//
//  Person.swift
//  Project10_NamesToFaces
//
//  Created by Konrad Cureau on 07/04/2022.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
