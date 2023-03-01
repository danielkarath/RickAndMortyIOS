//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/12/23.
//

import UIKit
import SwiftUI
import SafariServices
import MessageUI
import StoreKit

/// Controller for various settings and options
final class RMSettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    private var settingsSwiftUIControllerView: UIHostingController<RMSettingsView>?
    
    private var didRateApp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        title = "Settings"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let settingsSwiftUIVC = UIHostingController(
            rootView: RMSettingsView(
                viewModel: RMSettingsViewViewModel(
                    cellViewModels: RMSettingsOption.allCases.compactMap({
                        return RMSettingsCellViewModel(type: $0, onTapHandler: { [weak self] option in
                            self?.handleTap(option: option)
                        })
                    })
                )
            )
        )
        
        let swiftUIView: UIView = settingsSwiftUIVC.view
        addChild(settingsSwiftUIVC)
        settingsSwiftUIVC.didMove(toParent: self)
        view.addSubview(settingsSwiftUIVC.view)
        settingsSwiftUIVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swiftUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            swiftUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            swiftUIView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            swiftUIView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
        
        ])
        
        self.settingsSwiftUIControllerView = settingsSwiftUIVC
    }
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else { return }
        
        guard let url = option.targetURL else {
            if option == .rateApp {
                didTapRateApp()
            } else if option == .contact {
                showMailComposer()
            } else {
                print("Oppsie-poopsie")
            }
            return
        }
        
        if option == .viewSerries {
            let YoutubeUser =  "@iOSAcademy"
                let appURL = NSURL(string: "youtube://www.youtube.com/watch?v=EZpZDuOAFKE&list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")!
                let webURL = NSURL(string: "https://www.youtube.com/watch?v=EZpZDuOAFKE&list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")!
                let application = UIApplication.shared

                if application.canOpenURL(appURL as URL) {
                    application.open(appURL as URL)
                } else {
                    // if Youtube app is not installed, open URL inside Safari
                    application.open(webURL as URL)
                }
        } else {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.modalPresentationStyle = .popover
            present(safariViewController, animated: true)
        }
        
    }
    
    private func didTapRateApp() {
        guard  let scene = view.window?.windowScene else {
            print("No scene found for Rate window")
            return
        }
        
        if !didRateApp {
            didRateApp = true
            SKStoreReviewController.requestReview(in: scene)
        } else {
            if let url = URL(string: "itms-apps://itunes.apple.com") { ///app/id0000000000  - add your app url to the end here
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    private func showMailComposer() {
        guard MFMailComposeViewController.canSendMail()  else {
            print("Can't send mail")
            return
        }
        var mailMessageText: String = ""
        
        let systemVersion = UIDevice.current.systemVersion
        let appName: String = Bundle.main.appName!.addWhitespaceBeforeCapitalLetters()
        
        mailMessageText = "------------------------------------------\nOS version: \(systemVersion)\napp version: \(Bundle.main.appVersion ?? "1.0")\n------------------------------------------\nPlease don't delete or modify the above information.\n\n"
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["hello@danielkarath.com"])
        composer.setSubject("\(appName) app feedback")
        composer.setMessageBody(mailMessageText, isHTML: false)
        present(composer, animated: true)
    }
}
