//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/12/23.
//

import UIKit

/// Controller to house tabs and tab view controllers
final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let viewControllers: [UIViewController] = [RMCharacterViewController(), RMLocationViewController(), RMEpisodeViewController(), RMSettingsViewController()]
        let titles: [String] = ["Characters", "Locations", "Episodes", "Settings"]
        var navControllers: [UINavigationController] = []
        var i: Int = 0
        var j: Int = 0
        
        for viewController in viewControllers {
            viewController.navigationItem.largeTitleDisplayMode = .automatic
            navControllers.append(UINavigationController(rootViewController: viewControllers[i]))
            i = i + 1
        }
        for navController in navControllers {
            navController.navigationBar.prefersLargeTitles = true
            navController.tabBarItem = UITabBarItem(
                title: titles[j],
                image: nil,
                tag: j
            )
            j = j + 1
        }
        setViewControllers(navControllers, animated: true)
    }

}

