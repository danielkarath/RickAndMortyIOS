//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/15/23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    private let url: URL?
    
    //MARK: - Init
    
    init(url: URL?) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RMConstants.darkBackgroundColor
        title = "Episode"
    }


}
