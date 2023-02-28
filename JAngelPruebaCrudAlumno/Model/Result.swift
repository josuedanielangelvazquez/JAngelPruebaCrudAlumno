//
//  Result.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 22/02/23.
//

import Foundation

struct Result <T: Codable> : Codable{
    var Correct: Bool?
    var ErrorMessage: String?
    var Object: T?
    var Objects: [T?]?
}


