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
    
    
    /// This modifies the enum String outout so that it's always capitalized by default. Use "RMCharacterStatus.text" instead of "RMCharacterStatus.rawValue"
    var text: String {
        return self.rawValue.capitalized(with: .current)
    }
}
