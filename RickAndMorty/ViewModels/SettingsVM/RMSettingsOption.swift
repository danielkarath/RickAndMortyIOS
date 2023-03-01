//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/28/23.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case about
    case rateApp
    case contact
    case apiReference
    case privacy
    case viewSerries
    case viewCode
    
    var targetURL: URL? {
        switch self {
        case .about:
            return URL(string: "https://danielkarath.com")
        case .rateApp:
            return nil
        case .contact:
            return nil
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com")
        case .privacy:
            return URL(string: "https://www.iubenda.com/privacy-policy/93547013")
        case .viewSerries:
            return URL(string: "https://www.youtube.com/watch?v=EZpZDuOAFKE&list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/danielkarath/RickAndMortyIOS")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .about:
            return "About"
        case .rateApp:
            return "Rate App"
        case .contact:
            return "Contact Developer"
        case .apiReference:
            return "API Reference"
        case .privacy:
            return "Privacy Policy"
        case .viewSerries:
            return "View Video Series"
        case .viewCode:
            return "View source Code"
        }
        
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .about:
            return UIColor(named: "mainColor") ?? .systemGreen
        case .rateApp:
            return .systemYellow
        case .contact:
            return .systemOrange
        case .apiReference:
            return .systemPurple
        case .privacy:
            return .systemCyan
        case .viewSerries:
            return .systemRed
        case .viewCode:
            return .systemBlue
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .about:
            return UIImage(systemName: "person.fill")
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contact:
            return UIImage(systemName: "envelope.fill")
        case .apiReference:
            return UIImage(systemName: "doc.text")
        case .privacy:
            return UIImage(systemName: "lock.shield")
        case .viewSerries:
            return UIImage(systemName: "video")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
