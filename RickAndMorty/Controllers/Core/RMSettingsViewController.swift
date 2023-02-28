//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/12/23.
//

import UIKit
import SwiftUI

/// Controller for various settings and options
final class RMSettingsViewController: UIViewController {
    
    
    private let settingsSwiftUIControllerView = UIHostingController(
        rootView: RMSettingsView(
            viewModel: RMSettingsViewViewModel(
                cellViewModels: RMSettingsOption.allCases.compactMap({
                    return RMSettingsCellViewModel(type: $0)
                })
            )
        )
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        title = "Settings"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let swiftUIView: UIView = settingsSwiftUIControllerView.view
        addChild(settingsSwiftUIControllerView)
        settingsSwiftUIControllerView.didMove(toParent: self)
        view.addSubview(settingsSwiftUIControllerView.view)
        settingsSwiftUIControllerView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swiftUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            swiftUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            swiftUIView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            swiftUIView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
        
        ])
    }

}
