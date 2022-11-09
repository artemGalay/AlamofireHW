//
//  ViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

//MARK: - MainViewProtocol

protocol MainViewProtocol: AnyObject {
    func reloadCardsTableView()
}

final class MainViewController: UIViewController {

    //MARK: - Property

    private var presenter: MainPresenterProtocol?
    private var cardsUrl = "https://api.magicthegathering.io/v1/cards"

    // MARK: - UIElements

    private lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.barTintColor = UIColor.systemGray
        searchBar.placeholder = "Например: Condemn"
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var cardsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureDelegate()
        setupHierarchy()
        setupLayout()
    }

    //MARK: - ConfigureViewController

    private func configureVC() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Magic: The Gathering"

        presenter = MainPresenter(view: self, cards: [Card]())
        presenter?.fetchCards(url: cardsUrl)
    }

    //MARK: - Delegate and DataSource

    private func configureDelegate() {
        cardsTableView.delegate = self
        cardsTableView.dataSource = self

        searchBar.delegate = self
    }

    // MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(cardsTableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metric.searchBarTopOffset),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metric.searchBarLeadingOffset),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Metric.searchBarTrailingOffset),
            searchBar.heightAnchor.constraint(equalToConstant: Metric.searchBarHeightOffset),

            cardsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: - TableViewReloadData

extension MainViewController: MainViewProtocol {
    func reloadCardsTableView() {
        cardsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchCard(searchText: searchText)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.returnCardsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Metric.heightCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell
        cell?.configureCards(model: presenter?.getUsedCards(at: indexPath.row))
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let presenterDeteil = DetailPresenter()
        let viewController = DetailViewController(presenter: presenterDeteil)
        presenterDeteil.view = viewController
        viewController.presenter.showCard(model: presenter?.getUsedCards(at: indexPath.row) ?? Card())
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.present(viewController, animated: true)
    }
}

// MARK: - Constants

extension MainViewController {

    struct Metric {
        static let heightCell: CGFloat = 70

        static let searchBarTopOffset: CGFloat = 10
        static let searchBarLeadingOffset: CGFloat = 10
        static let searchBarTrailingOffset: CGFloat = -10
        static let searchBarHeightOffset: CGFloat = 40

        static let searchButtonLeadingOffset: CGFloat = 5
        static let searchButtonTrailingOffset: CGFloat = -10
        static let searchButtonHeightOffset: CGFloat = 40
    }
}
