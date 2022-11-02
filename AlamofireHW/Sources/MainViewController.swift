//
//  ViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    private lazy var animeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

//    var characters: [Card] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        fetchCharacter()
    }

    private func setupHierarchy() {
        view.addSubview(animeTableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            animeTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            animeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            animeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            animeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }

    private func fetchCharacter() {
        DispatchQueue.main.async {
            let request = AF.request("https://api.magicthegathering.io/v1/cards")
            request.responseDecodable(of: Cards.self) { data in
                guard let char = data.value else { return }
                let characters = char.data
                self.characters = characters
                self.animeTableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CardTableViewCell
        cell?.character = characters[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
