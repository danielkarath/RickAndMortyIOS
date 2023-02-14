//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/10/23.
//

import UIKit

/// Controller to display info about selected single character
final class RMCharacterDetailViewController: UIViewController {
    private let viewModel: RMCharacterDetailViewModel
    private let detailView: RMCharacterDetailView
    
    //MARK: Init
    
    init(viewModel: RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = RMConstants.darkBackgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        title = viewModel.title.capitalized(with: .current)
        addConstraints()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
        //viewModel.fetchCharacterData()
    }
    
    private func addConstraints() {
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    @objc private func didTapShare() {
        //Share character info
    }
    
}

//MARK: - CollectionView extension

extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    
}
