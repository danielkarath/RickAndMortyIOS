//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/13/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = RMConstants.setFont(fontSize: 18, isBold: true)
        label.text = "Earth"
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = RMConstants.setFont(fontSize: 11, isBold: false)
        label.textColor = RMConstants.secondaryTextColor
        label.text = "Location"
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "globe.europe.africa.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        return imageView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = RMConstants.midBackgroundColor
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(valueLabel, titleLabel, iconImageView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -25),
            
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            valueLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconImageView.image = nil
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        valueLabel.textColor = viewModel.tintColor
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
    }
    
}
