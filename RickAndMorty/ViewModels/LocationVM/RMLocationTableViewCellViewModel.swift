//
//  RMLocationTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/6/23.
//

import Foundation

struct RMLocationTableViewCellViewModel: Hashable, Equatable {
    
    private let location: RMLocation
    
    //MARK: - Init
    init(location: RMLocation) {
        self.location = location
    }
    
    //MARK: - Public
    public var name: String {
        return location.name
    }
    
    public var type: String {
        return "Type: " + location.type
    }
    
    public var dimension: String {
        var returnString: String = location.dimension
        if location.dimension != nil {
            returnString = returnString.replacingOccurrences(of: "Dimension", with: "")
        }
        if returnString == "unknown" {
            returnString = ""
        } else {
            returnString = "Dimension: " + returnString
        }
        return returnString
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(dimension)
        hasher.combine(location.id)
    }
}
