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
    case terms
    case privacy
    case viewSerries
    case viewCode
    
    var displayTitle: String {
        switch self {
        case .about:
            return "About"
        case .rateApp:
            return "Rate App"
        case .contact:
            return "Contact Developer"
        case .terms:
            return "Terms & Conditions"
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
        case .terms:
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
        case .terms:
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
