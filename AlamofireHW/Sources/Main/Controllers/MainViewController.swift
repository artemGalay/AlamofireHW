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
    var timer: Timer?

    // MARK: - UIElements

    private lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.barTintColor = UIColor.systemGray
        searchBar.placeholder = "Например: Condemn"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
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
        view.addSubview(cardsTableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: MetricMainViewController.searchBarTopAnchorConstraint),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MetricMainViewController.searchBarLeadingAnchorConstraint),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: MetricMainViewController.searchBarTrailingAnchorConstraint),
            searchBar.heightAnchor.constraint(equalToConstant: MetricMainViewController.searchBarHeightAnchorConstraint),

            cardsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: MetricMainViewController.cardsTableViewTopAnchorConstraint),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: MetricMainViewController.cardsTableViewBottomAnchorConstraint),
            cardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MetricMainViewController.cardsTableViewLeadingAnchorConstraint),
            cardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: MetricMainViewController.cardsTableViewTrailingAnchorConstraint)
        ])
    }

    //MARK: - Fetch Cards

    private func fetchCards(url: String) {
        let request = AF.request(url)
        request.responseDecodable(of: Cards.self) { [weak self]data in
            guard let data = data.value else { return }
            let cards = data.cards
            self?.cards = cards
            self?.cardsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if !searchText.isEmpty {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.cardsUrl = "https://api.magicthegathering.io/v1/cards?name=\(searchText)"
                self?.fetchCards(url: self?.cardsUrl ?? "")
            })
        } else {
            cardsUrl = MetricMainViewController.allCardsUrl
            fetchCards(url: cardsUrl)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MetricMainViewController.heightCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell
        cell?.configureCards(model: cards[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.configureDetailCards(model: cards[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.present(viewController, animated: true)
    }
}
