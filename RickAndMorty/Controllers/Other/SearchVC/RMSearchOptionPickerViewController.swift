//
//  RMSearchOptionPickerViewController.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 3/30/23.
//

import UIKit

final class RMSearchOptionPickerViewController: UIViewController {
    
    private let option: RMSearchInputViewViewModel.DynamicOption
    private let selectionBlock: ((String) -> Void)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = RMConstants.darkBackgroundColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    //MARK: - Init
    init(option: RMSearchInputViewViewModel.DynamicOption, selection: @escaping (String) -> Void ) {
        self.option = option
        self.selectionBlock = selection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RMConstants.darkBackgroundColor
        setupTableView()
        addConstraints()
    }
    
    //MARK: - Private
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }

}

extension RMSearchOptionPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let choice = option.choices[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = choice.capitalized
        cell.textLabel?.textColor = RMConstants.basicTextColor
        cell.backgroundColor = RMConstants.midBackgroundColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choice = option.choices[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectionBlock(choice)
        dismiss(animated: true)
    }
    
}
