//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/1/23.
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didLoadInitialLocations()
}

final class RMLocationViewViewModel {
    
    weak var delegate: RMLocationViewViewModelDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                cellViewModels.append(cellViewModel)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    private var apiInfo: RMGetLocationsResponse.Info?
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
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
        RMService.shared.execute(.listLocationsRequests, expecting: RMGetLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialLocations()
                }
            case .failure(let error):
                break
            }
        }
    }
    
}
