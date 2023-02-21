//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/19/23.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "episode title: "
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = RMConstants.highlightedTextColor
        label.font = RMConstants.setFont(fontSize: 14, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "la la la la la la la la la la la la la la la la la la la la la "
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = RMConstants.highlightedTextColor
        label.font = RMConstants.setFont(fontSize: 14, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(titleLabel, valueLabel)
        setupLayers()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupLayers() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = RMConstants.darkBackgroundColor
    }
    
    private func labelModifier() {
        if titleLabel.text == "Episode Title" {
            for label in [valueLabel, titleLabel] {
                label.font = RMConstants.setFont(fontSize: 14, isBold: true)
            }
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            titleLabel.widthAnchor.constraint(equalToConstant: 90),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            valueLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        labelModifier()
    }
    
}
