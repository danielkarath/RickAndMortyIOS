//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/13/23.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    let episodeDataURL: URL?
    init(episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
}
