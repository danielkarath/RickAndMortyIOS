//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/1/23.
//

import UIKit

class RMLocationView: UIView {
    
    private var viewModel: RMLocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            locationTableView.isHidden = false
            locationTableView.reloadData()
            UIView.animate(withDuration: 0.33, delay: 0) {
                self.locationTableView.alpha = 1.0
            }
        }
    }
    
    private let locationTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.alpha = 0
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = RMConstants.darkBackgroundColor
        addSubviews(locationTableView, spinner)
        spinner.startAnimating()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Private
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            
            locationTableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            locationTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            locationTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            locationTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }
    
    //MARK: - Public
    public func configure(with viewModel: RMLocationViewViewModel) {
        self.viewModel = viewModel
    }
    
}
