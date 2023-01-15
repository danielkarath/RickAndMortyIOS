//
//  RMGender.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/13/23.
//

import Foundation
/// The enum for the character's known gender identity
enum RMGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}
