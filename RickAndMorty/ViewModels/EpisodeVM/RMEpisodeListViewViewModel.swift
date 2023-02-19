//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/18/23.
//
import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}


/// RMEpisodeListViewViewModel View Model handles episode list view logic.
final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
    
    /// isLoadingMoreCharacters var is used as a guard against mutiple calls of fetchAdditionalEpisodes() by scrolling down.
    private var isLoadingMoreEpisodes: Bool = false
    
    /// Array of RMEpisode fetched by fetchEpisodes method. Whenever a character is fetched it's added to the cellViewModels (array of RMEpisodeCollectionViewCellViewModel) that is used to populate the cells with data.
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes {
                let viewModel = RMCharacterEpisodeCollectionViewCellViewModel(
                    episodeDataURL: URL(string: episode.url)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    /// Array of RMEpisodeCollectionViewCellViewModel to populate the RMEpisodeCollectionViewCell cells with data
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    
    /// The fetchCharacter method calls the execute API method in RMService that utilizes the Rick and Morthy API to fetch the initial 20 episodes.
    public func fetchEpisodes() {
        RMService.shared.execute(
            .listEpisodesRequests,
            expecting: RMGetAllEpisodesResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                self?.episodes = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginates if additional episodes are needed
    public func fetchAdditionalEpisodes(url: URL) {
        guard !isLoadingMoreEpisodes else {
            return
        }
        isLoadingMoreEpisodes = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreEpisodes = false
            print("Failled to create request")
            return
        }
        
        RMService.shared.execute(
            request,
            expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.apiInfo = info
                    let originalCount = strongSelf.episodes.count
                    let newCount = moreResults.count
                    let total = originalCount + newCount
                    let startingIndex = total - newCount
                    let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({
                        return IndexPath(row: $0, section: 0)
                    })
                    strongSelf.episodes.append(contentsOf: moreResults)
                    DispatchQueue.main.async {
                        strongSelf.delegate?.didLoadMoreCharacters(
                            with: indexPathsToAdd
                        )
                        strongSelf.isLoadingMoreEpisodes = false
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                    strongSelf.isLoadingMoreEpisodes = false
                }
            }
    }
    
    public var shouldShowLoadIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    
}

//MARK: CollectionView implementations

extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count ?? 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }

        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported kind")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let width = (screenBounds.width-32)
        return CGSize(width: width, height: width * 0.40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedEpisode = episodes[indexPath.row]
        delegate?.didSelectEpisode(selectedEpisode)
    }
    
}

//MARK: ScrollView implementation

extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    
    
    /// When there are additional characters available, the activityIndicator will appear once while loading them once scrolled down.
    /// - Parameter scrollView: The collectionViews scrollview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadIndicator,
              !isLoadingMoreEpisodes,
              !cellViewModels.isEmpty,
              let nextURLString = apiInfo?.next,
              let url = URL(string: nextURLString)
        else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalEpisodes(url: url)
            }
            timer.invalidate()
        }
    }
}
