//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/13/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    private let type: `Type`
    private let value: String
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    public var title: String {
        self.type.displayTitle
    }
    public var displayValue: String {
        if value.isEmpty { return "unknown" }
            //2017-11-04T18:50:21.651Z     yyyy-MM-dd HH:mm:ss
            //y-MM-dd H:mm:ss.SSSS
            if let date = Self.dateFormatter.date(from: value), type == .created {
                let result = Self.shortDateFormatter.string(from: date)
                print(result)
                return result
            }
        
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor? {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case species
        case gender
        case type
        case created
        case origin
        case location
        case episodeCount
        
        var tintColor: UIColor? {
            switch self {
            case .status:
                return .white
            case .species:
                return .white
            case .gender:
                return .white
            case .type:
                return .white
            case .created:
                return .white
            case .origin:
                return .white
            case .location:
                return .white
            case .episodeCount:
                return .white
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "cross.fill")
            case .species:
                return UIImage(systemName: "lizard.fill")
            case .gender:
                return UIImage(systemName: "person.fill")
            case .type:
                return UIImage(systemName: "aqi.medium")
            case .created:
                return UIImage(systemName: "calendar")
            case .origin:
                return UIImage(systemName: "fossil.shell.fill")
            case .location:
                return UIImage(systemName: "globe.europe.africa.fill")
            case .episodeCount:
                return UIImage(systemName: "play.tv.fill")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status, .species, .gender, .type, .created, .origin, .location:
                return self.rawValue.capitalized
            case .episodeCount:
                return "Episode Count"
            }
        }
        
    }
    
//        .init(value: character.status.text, title: "Status"),
//        .init(value: character.species, title: "Species"),
//        .init(value: character.gender.rawValue, title: "Gender"),
//        .init(value: character.type, title: "Type"),
//        .init(value: character.created, title: "Created"),
//        .init(value: character.origin.name, title: "Origin"),
//        .init(value: character.location.name, title: "Location"),
//        .init(value: "\(character.episode.count)", title: "Total Episodes"),
    
    init(
        type: `Type`,
        value: String
    ) {
        self.value = value
        self.type = type
    }
}
