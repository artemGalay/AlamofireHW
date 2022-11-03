//
//  DetailViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

class DetailViewController: UIViewController {

    var cards: Card?

    // MARK: - UIElements

    private let manaCostLabel = UILabel(numberOfLines: 2)

    private let idLabel = UILabel(numberOfLines: 3)

    private let setNameLabel = UILabel(numberOfLines: 1)

    private let textLabel = UILabel(numberOfLines: 10)

    private let artistLabel = UILabel(numberOfLines: 1)

    private let numberLabel = UILabel(numberOfLines: 1)

    private let powerLabel = UILabel(numberOfLines: 1)

    private lazy var stackView = UIStackView(arrangeSubview: [manaCostLabel,
                                                              idLabel,
                                                              setNameLabel,
                                                              textLabel,
                                                              artistLabel,
                                                              numberLabel,
                                                              powerLabel],
                                             axis: .vertical,
                                             spacing: 10,
                                             distribution: .fillProportionally)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        configure()
    }

    private func setupHierarchy() {
        view.addSubview(stackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }

    private func configure() {
//        manaCostLabel.text = "manaCost: \((cards?.manaCost) ?? "")"
//        idLabel.text = "id: \((cards?.id) ?? "")"
//        setNameLabel.text = "setName: \((cards?.setName.rawValue) ?? "")"
//        textLabel.text = "text: \((cards?.text) ?? "")"
//        artistLabel.text = "artist: \((cards?.artist) ?? "")"
//        numberLabel.text = "number: \((cards?.number) ?? "")"
//        powerLabel.text = "power: \((cards?.power) ?? "")"
    }
}
