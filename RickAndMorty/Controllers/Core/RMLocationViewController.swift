//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/12/23.
//

import UIKit

/// Controller to show and serach for location
final class RMLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        title = "Locations"
        addSearchButton()
        // Do any additional setup after loading the view.
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearch)
        )
    }
    
    
    @objc private func didTapSearch() {
        
    }

}
