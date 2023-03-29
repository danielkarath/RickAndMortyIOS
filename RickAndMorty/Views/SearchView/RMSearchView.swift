//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/29/23.
//

import UIKit

class RMSearchView: UIView {
    
    private let viewModel: RMSearchViewViewModel
    
    private let noResultsView = RMNoSearchResultsView()
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = RMConstants.darkBackgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView)
        //spinner.startAnimating()
        addConstraints()
        //configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Private
    private func addConstraints() {
        let noResultSize: CGFloat = 150
        
        NSLayoutConstraint.activate([
            noResultsView.widthAnchor.constraint(equalToConstant: noResultSize),
            noResultsView.heightAnchor.constraint(equalToConstant: noResultSize),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
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
