//
//  RMNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/29/23.
//

import UIKit

final class RMNoSearchResultsView: UIView {
    
    private let viewModel = RMNoSearchResultsViewViewModel()
    
    private let iconImageView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = RMConstants.inactiveTextColor
        return iconView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = RMConstants.setFont(fontSize: 20, isBold: true)
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = RMConstants.darkBackgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(iconImageView, label)
        addConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Private
    private func addConstraints() {
        let iconSize: CGFloat = 90
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            iconImageView.heightAnchor.constraint(equalToConstant: iconSize),
            iconImageView.widthAnchor.constraint(equalToConstant: iconSize),
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            //label.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    //MARK: - Public
    public func configure() {
        label.text = viewModel.title
        iconImageView.image = viewModel.image
    }
}
