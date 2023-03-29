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
    private let viewModel: RMSearchViewViewModel
    
    private let searchView: RMSearchView
    
    //MARK: - Init
    
    init(config: Config) {
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = RMConstants.darkBackgroundColor
        view.addSubview(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapExecuteSearch)
        )
    }
    
    //MARK: - Private
    private func addConstraints() {
        let noResultSize: CGFloat = 150
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    @objc
    private func didTapExecuteSearch() {
        //viewModel.exevuteSearch()
    }


}
