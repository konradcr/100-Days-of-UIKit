//
//  Petition.swift
//  Project7_WhitehousePetitions
//
//  Created by Konrad Cureau on 06/04/2022.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
