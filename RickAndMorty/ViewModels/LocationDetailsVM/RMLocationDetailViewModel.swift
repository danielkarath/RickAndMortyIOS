//
//  RMLocationDetailViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/6/23.
//
import UIKit

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewViewModel: NSObject {
    
    private let endpointURL: URL?
    
    private var dataTuple: (location: RMLocation,characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    //MARK: - Public
    public weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else { return nil }
        return dataTuple.characters[index]
    }
    
    public private(set) var cellViewModels: [SectionType] = [] //this means that it's publicly readable but can only write it in this class
    
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
        let location = dataTuple.location
        let characters = dataTuple.characters
        let locationCreatedString = generateCreateDate(with: location.created)
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Title", value: location.name),
                .init(title: "Type:", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: locationCreatedString)
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
    
    ///Fetch location model
    public func fetchLocationData() {
        guard let url = endpointURL,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                print(String(describing: model))
                self?.fetchRelatedCharacters(location: model)
            case .failure(let failure):
                break
            }
        }
    }
    
    private func fetchRelatedCharacters(location: RMLocation) {
        let requests: [RMRequest] = location.residents.compactMap({
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
                location: location,
                characters: characters
            )
        }
    }
    
    private func generateCreateDate(with createdString: String) -> String {
        var returnString: String = ""
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.timeZone = .current
            return formatter
        }()
        
        let shortDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter
        }()
        
        if let date = dateFormatter.date(from: createdString) {
            returnString = shortDateFormatter.string(from: date) ?? ""
        }
        
        return returnString
    }
}
