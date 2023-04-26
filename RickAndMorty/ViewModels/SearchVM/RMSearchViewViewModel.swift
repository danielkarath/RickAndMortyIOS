//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/29/23.
//

import Foundation

//Responsibilities
// - show search results
// - show no results view
// - initiate API Request


final class RMSearchViewViewModel {
    public let config: RMSearchViewController.Config
    
    //MARK: - Init
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    //MARK: - Private
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var searchText = ""
    
    //MARK: - Public
    public func exevuteSearch() {
        var urlsString: String = "https://rickandmortyapi.com/api/"
        //https://rickandmortyapi.com/api/character/?page=2&name=rick&status=alive
        switch config.type {
        case .character:
            urlsString += "character"
            urlsString += "?name=\(searchText)"
//            urlsString += "?name=Rick"
            
            for (option, value) in optionMap {
                urlsString += "&\(option.querryArgument)=\(value)"
            }
            print("url: \(urlsString)")
            guard let url = URL(string: urlsString), let request = RMRequest(url: url) else {return}
            
            RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
                switch result {
                case .success(let model):
                    print("Search results found: \(model.results.count)")
                case .failure(let error):
                    //Should handle searches w no results
                    print("Failled to get search result due to ERROR\nerror: \(error.localizedDescription)")
                    break
                }
            }
            
        case .episode:
            urlsString += "episode"
            break
        case .location:
            urlsString += "location"
            break
        }
        
    }
    
    public func set(querry text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
}
