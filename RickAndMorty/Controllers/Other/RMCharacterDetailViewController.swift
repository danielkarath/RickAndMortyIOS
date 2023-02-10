//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/10/23.
//

import UIKit

/// Controller to display info about selected single character
final class RMCharacterDetailViewController: UIViewController {
    private let viewModel: RMCharacterDetailViewModel
    //MARK: Init
    
    init(viewModel: RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = RMConstants.darkBackgroundColor
        title = viewModel.title.capitalized(with: .current)
    }

}
