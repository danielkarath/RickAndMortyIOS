//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/12/23.
//

import Foundation

/// Model for the location based elements
struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
