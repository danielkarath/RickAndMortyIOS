//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/13/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.zPosition = 1
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = RMConstants.activeBackgroundColor
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageOuterView: UIView = {
        let view = UIView()
        view.layer.zPosition = 3
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        view.backgroundColor = RMConstants.midBackgroundColor
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = RMConstants.basicTextColor
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 6
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = RMConstants.basicTextColor
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = RMConstants.secondaryTextColor
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 8
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
        contentView.addSubviews(seasonLabel, episodeLabel, titleLabel, airDateLabel, imageOuterView)
        imageOuterView.addSubview(imageView)
        addConstraints()
        setupGradientView(view: imageOuterView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            imageOuterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 140),
            imageOuterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageOuterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            imageOuterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            imageView.leadingAnchor.constraint(equalTo: imageOuterView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: imageOuterView.trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: imageOuterView.bottomAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: imageOuterView.topAnchor, constant: 0),
            
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            seasonLabel.widthAnchor.constraint(equalToConstant: 60),
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            seasonLabel.heightAnchor.constraint(equalToConstant: 30),
            
            episodeLabel.leadingAnchor.constraint(equalTo: seasonLabel.trailingAnchor, constant: 0),
            episodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            episodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            episodeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -64),
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
            self?.titleLabel.text = data.name ?? "Unknown title"
            self?.episodeLabel.text = "Episode " + (data.episode.dropFirst(3)).dropFirst()
            self?.seasonLabel.text = "Season " + (data.episode.dropLast(3)).dropFirst() //The API displays in one string "episode" both the season and the episode
            self?.airDateLabel.text = "Aired on " + data.air_date
            self?.imageView.image = UIImage(named: (data.name ?? "Pilot"))
        }
        viewModel.fetchEpisode()
    }
    
    private func setupGradientView(view: UIView) {
        let gradientLayer = CAGradientLayer()
        var coverColors: [CGColor] = []
        
        let leadingColor: CGColor = RMConstants.midBackgroundColor.withAlphaComponent(1.0).cgColor
        let trailingColor: CGColor = RMConstants.midBackgroundColor.withAlphaComponent(0.1).cgColor
        coverColors.append(leadingColor)
        coverColors.append(trailingColor)
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = coverColors
        gradientLayer.locations = [0.08, 0.70]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame.size = CGSize(width: contentView.frame.width, height: contentView.frame.height)
        gradientLayer.zPosition = 2
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
