//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/13/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = RMConstants.basicTextColor
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = RMConstants.basicTextColor
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = RMConstants.secondaryTextColor
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.contentMode = .topLeft
        label.numberOfLines = 0
        label.font = RMConstants.setFont(fontSize: 20, isBold: true)
        label.textColor = RMConstants.basicTextColor
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = RMConstants.midBackgroundColor
        contentView.addSubviews(seasonLabel, episodeLabel, titleLabel, airDateLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            seasonLabel.widthAnchor.constraint(equalToConstant: 60),
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            seasonLabel.heightAnchor.constraint(equalToConstant: 30),
            
            episodeLabel.leadingAnchor.constraint(equalTo: seasonLabel.trailingAnchor, constant: 0),
            episodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            episodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            episodeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 65),
            
            airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            airDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            airDateLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        episodeLabel.text = nil
        titleLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.titleLabel.text = "Title " + data.name
            self?.episodeLabel.text = "Episode " + (data.episode.dropFirst(3)).dropFirst()
            self?.seasonLabel.text = "Season " + (data.episode.dropLast(3)).dropFirst() //The API displays in one string "episode" both the season and the episode
            self?.airDateLabel.text = "Aired on " + data.air_date
        }
        viewModel.fetchEpisode()
    }
    
}
