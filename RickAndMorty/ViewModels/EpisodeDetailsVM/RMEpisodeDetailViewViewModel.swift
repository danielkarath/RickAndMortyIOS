//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/15/23.
//

import UIKit

class RMEpisodeDetailViewViewModel: NSObject {

    private let endpointURL: URL?
    
    //MARK: - Init
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
        super.init()
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endpointURL,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                break
            }
        }
    }
}
