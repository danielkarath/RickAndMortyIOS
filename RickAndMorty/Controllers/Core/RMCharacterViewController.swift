//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/12/23.
//

import UIKit

/// Controller to show and serach for characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        
        let request = RMRequest(
            endpoint: .character,
            querryParameters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "status", value: "alive"),
            ]
        )
                
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: "+String(model.info.pages))
                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

}
