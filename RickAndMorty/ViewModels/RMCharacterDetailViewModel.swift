//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/10/23.
//

import Foundation
import UIKit

final class RMCharacterDetailViewModel {
    
    private let character: RMCharacter
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    //MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var requestURL: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    /*
    public func fetchCharacterData() {
        guard let url = requestURL,
              let request = RMRequest(url: url) else {
            return
        }
        RMService.shared.execute(
            request,
            expecting: RMCharacter.self) { result in
                switch result {
                case .success(let success):
                    print(String(describing: success))
                case .failure(let failure):
                    print(String(describing: failure))
                }
            }
    }
    */
}
