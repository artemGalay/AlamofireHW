//
//  ViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    var magicUrl = "https://api.magicthegathering.io/v1/cards"

    var cards: [Card] = []

    // MARK: - UIElements

//    private let searchTextfield: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Search card name"
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.cornerRadius = 5
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()

    var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.barTintColor = UIColor(displayP3Red: 0.96, green: 0.96, blue: 0.98, alpha: 1)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "searchButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
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



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchCards()
        setupHierarchy()
        setupLayout()


    }

    private func setupHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(searchButton)
        view.addSubview(cardsTableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            searchBar.heightAnchor.constraint(equalToConstant: 30),

            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 30),

            cardsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            cardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            cardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }

    func fetchCards() {
        DispatchQueue.main.async {
            let request = AF.request(self.magicUrl)
            request.responseDecodable(of: Cards.self) { data in
                guard let char = data.value else { return }
                let cardss = char.cards
                self.cards = cardss

                self.cardsTableView.reloadData()
            }
        }
    }

    @objc func tapButton() {
        if searchBar.text?.isEmpty == false {
            magicUrl = "https://api.magicthegathering.io/v1/cards?name=\(searchBar.text ?? "")"
//            DispatchQueue.main.async {
                fetchCards()
//            }
//            showAlert()
        } else {
            magicUrl = "https://api.magicthegathering.io/v1/cards"
            fetchCards()
        }
    }

//    @objc func searchButtonTapped() {
//        if searchBar.text?.isEmpty == false {
////            print(searchTextfield.text ?? "")
//            url = "https://api.magicthegathering.io/v1/cards?name=\(searchBar.text ?? "")"
//
////            DispatchQueue.main.async {
//                fetchCharacter()
////            }
//            } else {
//                url = "https://api.magicthegathering.io/v1/cards"
//                fetchCharacter()
//            }
//        }
    }



// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell
        cell?.card = cards[indexPath.row]
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.cards = cards[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        present(viewController, animated: true)
    }
}
