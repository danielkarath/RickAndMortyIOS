//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/22/23.
//

import UIKit

///Single cell for a character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "RMCharacterCollectionViewCell"
    
    let detailBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.layer.zPosition = 3
        //view.layer.cornerRadius = 0
        //view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = RMConstants.midBackgroundColor.withAlphaComponent(0.03)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let detailViewColorView: UIView = {
        let view = UIView()
        view.alpha = 0.17
        view.layer.zPosition = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.zPosition = 1
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = RMConstants.activeBackgroundColor
        imageView.image = UIImage(named: "RickAndMortyCharacterPlaceholderImage")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 5
        label.text = "name sample text"
        label.textColor = RMConstants.highlightedTextColor
        label.font = RMConstants.setFont(fontSize: 18, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 4
        label.text = "status sample text"
        label.textColor = RMConstants.secondaryTextColor
        label.font = RMConstants.setFont(fontSize: 12, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Init 
    
    override init(frame: CGRect) {
        super.init(frame:  frame)
        overrideUserInterfaceStyle = .dark
        contentView.backgroundColor = RMConstants.midBackgroundColor
        contentView.layer.cornerRadius = 16
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        imageView.addSubviews(detailViewColorView, detailBlurView)
        setupConstraints()
        setupGradientView(view: detailViewColorView)
        //fullBlurView.addSubviews(nameLabel, statusLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            detailViewColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            detailViewColorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            detailViewColorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            detailViewColorView.heightAnchor.constraint(equalToConstant: 48),
            
            detailBlurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            detailBlurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            detailBlurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            detailBlurView.heightAnchor.constraint(equalToConstant: 48),
            
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: 10),

        ])
    }
    
    private func setupGradientView(view: UIView) {
        let gradientLayer = CAGradientLayer()
        var coverColors: [CGColor] = []
        
        let bottomColor: CGColor = RMConstants.mainColor.cgColor
        let topColor: CGColor = UIColor.clear.withAlphaComponent(0.0).cgColor
        coverColors.append(topColor)
        coverColors.append(bottomColor)
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = coverColors
        gradientLayer.locations = [0.0, 0.70]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame.size = CGSize(width: contentView.frame.width, height: 48)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatus
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
                break
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            }
        }
    }
    
}
