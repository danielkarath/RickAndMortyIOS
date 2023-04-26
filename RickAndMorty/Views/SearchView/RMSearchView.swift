//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/29/23.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

class RMSearchView: UIView {
    
    weak var delegate: RMSearchViewDelegate?
    
    private let viewModel: RMSearchViewViewModel
    
    private let searchInputView = RMSearchInputView()
    
    private let noResultsView = RMNoSearchResultsView()
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = RMConstants.darkBackgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView, searchInputView)
        //spinner.startAnimating()
        addConstraints()
        searchInputView.configure(with: .init(type: viewModel.config.type))
        searchInputView.delegate = self
        
        viewModel.registerOptionChangeBlock { tuple in
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Private
    private func addConstraints() {
        let noResultViewSize: CGFloat = 150
        guard viewModel.config.type != nil else {return}
        let searchInputViewHeight: CGFloat = viewModel.config.type != .episode ? 120 : 64
        
        NSLayoutConstraint.activate([
            //No Results View
            noResultsView.widthAnchor.constraint(equalToConstant: noResultViewSize),
            noResultsView.heightAnchor.constraint(equalToConstant: noResultViewSize),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            
            //Search Input View
            searchInputView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            searchInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            searchInputView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            searchInputView.heightAnchor.constraint(equalToConstant: searchInputViewHeight)
        ])
    }
    
    //MARK: - Public
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
    
}

//MARK: - CollectionView 

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

//MARK: - RMSearchInputViewDelegate

extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
    
    
}
