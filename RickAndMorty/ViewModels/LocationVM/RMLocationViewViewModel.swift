//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/1/23.
//

import Foundation

final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = []
    
    private var cellViewModels: [String] = []
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    //MARK: - Private
    private var hasMoreResults: Bool {
        return false
    }
    
    //MARK: - Public
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsRequests, expecting: String.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let error):
                break
            }
        }
    }
    
}
