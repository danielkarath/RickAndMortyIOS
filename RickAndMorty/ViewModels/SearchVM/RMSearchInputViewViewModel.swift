//
//  RMSearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/29/23.
//

import Foundation

final class RMSearchInputViewViewModel {
    
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case species = "Species"
        case locationType = "Location Type"
        
        var choices: [String] {
            switch self {
            case .status:
                return [
                    "alive",
                    "dead",
                    "unknown"
                ]
            case .gender:
                return [
                    "female",
                    "male",
                    "genderless",
                    "unknown"
                ]
            case .species:
                return [
                    "human",
                    "humanoid",
                    "robot",
                    "animal",
                    "disease",
                    "cronenberg",
                    "mythological creature",
                    "alien",
                    "poopybutthole",
                    "unknown"
                ]
            case .locationType:
                return [
                    "planet",
                    "cluster",
                    "space station",
                    "microverse",
                    "dream",
                    "tv",
                    "fantasy town",
                    "resort"
                ]
            default:
                fatalError()
            }
        }
    }
    
    //MARK: - Init
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    //case character: name | status | gender | species
    //case location: name | type
    //case episode: name
    
    //MARK: - Public
    public var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender, .species]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    
    public var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Character name"
        case .location:
            return "Location name"
        case .episode:
            return "Episode title"
        }
    }
    
}
