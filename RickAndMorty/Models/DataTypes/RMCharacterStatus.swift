//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/13/23.
//

import Foundation

/// The enum for the character's current state of "well being"
enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}
