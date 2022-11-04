//
//  ViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit
import Alamofire

final class MainViewController: UIViewController {

    //MARK: - Property

    var cardsUrl = MetricMainViewController.allCardsUrl
    var cards: [Card] = []

    // MARK: - UIElements

    private let searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.barTintColor = UIColor.systemGray
        searchBar.placeholder = "Например: Condemn"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage((MetricMainViewController.searchButtonImage).withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cardsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Magic: The Gathering"
        setupHierarchy()
        setupLayout()
        fetchCards(url: cardsUrl)
    }

    // MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(searchButton)
        view.addSubview(cardsTableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: MetricMainViewController.searchBarTopAnchorConstraint),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MetricMainViewController.searchBarLeadingAnchorConstraint),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: MetricMainViewController.searchBarTrailingAnchorConstraint),
            searchBar.heightAnchor.constraint(equalToConstant: MetricMainViewController.searchBarHeightAnchorConstraint),

            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: MetricMainViewController.searchButtonLeadingAnchorConstraint),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: MetricMainViewController.searchButtonTrailingAnchorConstraint),
            searchButton.heightAnchor.constraint(equalToConstant: MetricMainViewController.searchButtonHeightAnchorConstraint),

            cardsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: MetricMainViewController.cardsTableViewTopAnchorConstraint),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: MetricMainViewController.cardsTableViewBottomAnchorConstraint),
            cardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MetricMainViewController.cardsTableViewLeadingAnchorConstraint),
            cardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: MetricMainViewController.cardsTableViewTrailingAnchorConstraint)
        ])
    }

    //MARK: - Fetch Cards

    private func fetchCards(url: String) {
        DispatchQueue.main.async {
            let request = AF.request(url)
            request.responseDecodable(of: Cards.self) { data in
                guard let data = data.value else { return }
                let cards = data.cards
                self.cards = cards
                self.cardsTableView.reloadData()
            }
        }
    }

    //MARK: - Button Action

    @objc private func tapButton() {
        if !(searchBar.text?.isEmpty ?? true) {
            cardsUrl = "https://api.magicthegathering.io/v1/cards?name=\(searchBar.text ?? "")"
            fetchCards(url: cardsUrl)
        } else {
            let allertController = UIAlertController(title: "ERROR", message: "Введите название карты", preferredStyle: .alert)
            let allertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            allertController.addAction(allertAction)
            present(allertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MetricMainViewController.heightCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func prepareForReuse() {
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell
        cell?.card = cards[indexPath.row]
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.card = cards[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.present(viewController, animated: true)
    }
}
