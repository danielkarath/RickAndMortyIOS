//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/12/23.
//

import UIKit

/// Controller to house tabs and tab view controllers
final class RMTabViewController: UITabBarController {

    private let fullBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        //view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.clipsToBounds = true
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = RMConstants.midBackgroundColor
        setupTabs()
    }

    private func setupTabs() {
        view.backgroundColor = RMConstants.darkBackgroundColor.withAlphaComponent(0.0)
        view.addSubview(fullBlurView)
        let viewControllers: [UIViewController] = [RMCharacterViewController(), RMLocationViewController(), RMEpisodeViewController(), RMSettingsViewController()]
        let inactiveMenuIcons: [UIImage] = [UIImage(named: "characterIconInactive")!, UIImage(named: "locationIconInactive")!, UIImage(named: "movieIconInactive")!, UIImage(named: "settingsIconInactive")!]
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
            navController.navigationBar.titleTextAttributes = [.foregroundColor: RMConstants.highlightedTextColor]
            navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: RMConstants.highlightedTextColor]
            navController.navigationBar.addSubview(fullBlurView)
            navController.navigationBar.backgroundColor = RMConstants.darkBackgroundColor.withAlphaComponent(0.0)
            tabBar.tintColor = RMConstants.mainColor
            tabBar.layer.cornerRadius = 16
            tabBar.layer.masksToBounds = true
            navController.tabBarItem = UITabBarItem(
                title: titles[j],
                image: inactiveMenuIcons[j],
                tag: j
            )
            j = j + 1
        }
        setViewControllers(navControllers, animated: true)
    }

}

