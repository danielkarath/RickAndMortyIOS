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
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
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
        configureTableView()
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
    
    private func configureTableView() {
        locationTableView.delegate = self
        locationTableView.dataSource = self
        
    }
    
    //MARK: - Public
    public func configure(with viewModel: RMLocationViewViewModel) {
        self.viewModel = viewModel
    }
    
}

extension RMLocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Notify controller of selection
    }
}

extension RMLocationView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError()
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RMLocationTableViewCell.cellIdentifier,
            for: indexPath
        ) as? RMLocationTableViewCell else {
            fatalError()
        }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.textLabel?.text = cellViewModel.name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
