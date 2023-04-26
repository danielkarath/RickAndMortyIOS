//
//  RMSearchInputView.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/29/23.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchInputView: UIView {

    weak var delegate: RMSearchInputViewDelegate?
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                
                return
            }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
        }
    }
    
    private var stackView: UIStackView?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.removeBackground()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = RMConstants.darkBackgroundColor
        addSubviews(searchBar)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    private func generateOptionsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 16
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        return stackView
    }
    
    private func generateButton(with option: RMSearchInputViewViewModel.DynamicOption, tag: Int) -> UIButton {
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(
                string: option.rawValue,
                attributes: [
                    .font: RMConstants.setFont(fontSize: 18, isBold: false),
                    .foregroundColor: RMConstants.basicTextColor
                ]
            ),
            for: .normal
        )
        button.backgroundColor = RMConstants.activeBackgroundColor
        button.layer.cornerRadius = 8
        button.tag = tag
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return button
    }
    
    private func createOptionSelectionViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
        if options.count > 0 {
            let stackView = generateOptionsStackView()
            self.stackView = stackView
            for x in 0..<options.count {
                let option = options[x]
                let button = generateButton(with: option, tag: x)
                stackView.addArrangedSubview(button)
            }
        }
    }
    
    @objc
    private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else {return}
        let tag = sender.tag
        let selectedOption = options[tag]
        delegate?.rmSearchInputView(self, didSelectOption: selectedOption)
    }
    
    //MARK: - Public
    public func configure(with viewModel: RMSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    public func presentKeyboard() {
        if !searchBar.isFirstResponder {
            searchBar.becomeFirstResponder()
        }
    }
    
    public func update(option: RMSearchInputViewViewModel.DynamicOption, value: String) {
        guard let buttons = self.stackView?.arrangedSubviews,
              let allOptions = viewModel?.options,
              let index = allOptions.firstIndex(of: option),
              let button: UIButton = buttons[index] as? UIButton else {
            return
        }
        //button.setTitle(value, for: .normal)
        button.setAttributedTitle(
            NSAttributedString(
                string: value.capitalized,
                attributes: [
                    .font: RMConstants.setFont(fontSize: 18, isBold: false),
                    .foregroundColor: RMConstants.highlightedTextColor
                ]
            ),
            for: .normal
        )
    }
}
