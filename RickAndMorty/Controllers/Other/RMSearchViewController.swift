//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/19/23.
//

import UIKit

// Configurable controller to search using the Rick and Morty API filter
final class RMSearchViewController: UIViewController {
    
    /// Configuration options for the search session
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .episode:
                    return "Search Episodes"
                case .location:
                    return "Search Locations"
                }
            }
        }
        let type: `Type`
    }
    
    private let config: Config
    
    //MARK: - Init
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = RMConstants.darkBackgroundColor
    }


}
