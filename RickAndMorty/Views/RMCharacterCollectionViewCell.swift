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
    
    let fullBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.layer.zPosition = 2
        view.layer.cornerRadius = 8
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = RMConstants.midBackgroundColor.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .red
        //view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.clipsToBounds = true
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.zPosition = 1
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = RMConstants.activeBackgroundColor
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 4
        label.text = "name sample text"
        label.textColor = RMConstants.highlightedTextColor
        label.font = RMConstants.setFont(fontSize: 20, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 3
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
        contentView.addSubviews(fullBlurView, imageView, nameLabel, statusLabel)
        setupConstraints()
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
            
            fullBlurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            fullBlurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            fullBlurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            fullBlurView.heightAnchor.constraint(equalToConstant: 48),
            
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
