//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/15/23.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel: NSObject {
    
    private let endpointURL: URL?
    
    private var dataTuple: (episode: RMEpisode,characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    //MARK: - Public
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    public private(set) var sections: [SectionType] = [] //this means that it's publicly readable but can only write it in this class
    
    //MARK: - Init
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
        super.init()
    }
    
    //MARK: - Private
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        sections = [
            .information(viewModels: [
                .init(title: "Episode Title", value: episode.name),
                .init(title: "Air date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: episode.created)
            ]),
            .characters(viewModel: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatusText: character.status,
                    characterImageURL: URL(string: character.image)
                )
            }))
        ]
    }
    
    ///Fetch episode model
    public func fetchEpisodeData() {
        guard let url = endpointURL,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                print(String(describing: model))
                self?.fetchRelatedCharacters(episode: model)
            case .failure(let failure):
                break
            }
        }
    }
    
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests: [RMRequest] = episode.characters.compactMap({
            return URL(string: $0) // creates collection oif URLs from strings
        }).compactMap({
            return RMRequest(url: $0) // creates collection of RMRequests from the previously created URLs
        })
        
        //n of parallel requests
        //Notified once all done
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave() // defer is the last thing to run of the codeblock before execution and return
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        }
    }
}
