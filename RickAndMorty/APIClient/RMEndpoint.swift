//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/13/23.
//

import Foundation

/// Represents unique API endpoints
@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    ///Endpoint to get character info
    case character = "character"
    ///Endpoint to get location info
    case location = "location"
    ///Endpoint to get episode info
    case episode = "episode"
}
