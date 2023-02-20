//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/19/23.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupLayers() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = RMConstants.darkBackgroundColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        
    }
    
}
