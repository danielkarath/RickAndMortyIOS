//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/15/23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    private let viewModel: RMEpisodeDetailViewViewModel
    
    //MARK: - Init
    
    init(url: URL?) {
        self.viewModel = .init(endpointURL: url)
        
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
