//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/22/23.
//

import Foundation

struct RMCharacterCollectionViewCellViewModel {
    
public let characterName: String
private let characterStatusText: RMCharacterStatus
private let characterImageURL: URL?
    
    init(
        characterName: String,
        characterStatusText: RMCharacterStatus,
        characterImageURL: URL?
    ) {
        self.characterName = characterName
        self.characterStatusText = characterStatusText
        self.characterImageURL = characterImageURL
    }
    
    public var characterStatus: String {
        return "Status: \(characterStatusText.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        //TODO Abstract to Image Manager 
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
