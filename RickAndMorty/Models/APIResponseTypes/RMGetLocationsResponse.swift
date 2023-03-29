//
//  RMGetLocationsResponse.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/6/23.
//

import Foundation
struct RMGetLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
        
    }
    let info: Info
    let results: [RMLocation]
}
