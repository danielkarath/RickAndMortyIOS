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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemPurple
        } else {
            cell.backgroundColor = .systemBlue
        }
        return cell
    }
    
    
}
