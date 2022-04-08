//
//  Picture.swift
//  Milestone10_12
//
//  Created by Konrad Cureau on 08/04/2022.
//

import Foundation

class Picture: Codable {
    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
}
