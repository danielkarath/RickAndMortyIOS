//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/6/23.
//

import UIKit


final class RMLocationTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "RMLocationTableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "name sample text"
        label.textColor = RMConstants.highlightedTextColor
        label.font = RMConstants.setFont(fontSize: 18, isBold: true)
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "name sample text"
        label.textColor = RMConstants.secondaryTextColor
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        return label
    }()

    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "name sample text"
        label.textColor = RMConstants.secondaryTextColor
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = RMConstants.midBackgroundColor
        contentView.addSubviews(nameLabel, typeLabel, dimensionLabel)
        setupConstraints()
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.typeLabel.text = nil
        self.dimensionLabel.text = nil
    }
    
    //MARK: - Public
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.typeLabel.text = viewModel.type
        self.dimensionLabel.text = viewModel.dimension
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            dimensionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            dimensionLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 8),
            dimensionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

        ])
    }
    
}
