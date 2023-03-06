//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/6/23.
//

import UIKit

final class RMLocationTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "RMLocationTableViewCell"

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = RMConstants.midBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    //MARK: - Public
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        
    }
    
}
