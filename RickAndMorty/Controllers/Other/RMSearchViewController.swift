//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/19/23.
//

import UIKit

// Configurable controller to search using the Rick and Morty API filter
final class RMSearchViewController: UIViewController {

    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        let type: `Type`
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = RMConstants.darkBackgroundColor
    }


}
