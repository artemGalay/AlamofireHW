//
//  DetailViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

final class DetailViewController: UIViewController {

    //MARK: - Property

    var cards: Card?

    // MARK: - UIElements

    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let manaCostLabel = UILabel(numberOfLines: 2)

    private let typeLabel = UILabel(numberOfLines: 3)

    private let rarityLabel = UILabel(numberOfLines: 1)

    private let textLabel = UILabel(numberOfLines: 10)

    private let artistLabel = UILabel(numberOfLines: 1)

    private let setLabel = UILabel(numberOfLines: 1)

    private lazy var stackView = UIStackView(arrangeSubview: [manaCostLabel,
                                                              typeLabel,
                                                              rarityLabel,
                                                              textLabel,
                                                              artistLabel,
                                                              setLabel],
                                             axis: .vertical,
                                             spacing: 10,
                                             distribution: .fillProportionally)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        configure()
    }

    // MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(stackView)
        view.addSubview(cardImage)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            cardImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cardImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cardImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cardImage.heightAnchor.constraint(equalToConstant: 500),

            stackView.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }

    // MARK: - Configure

    private func configure() {
        manaCostLabel.text = "manaCost: \((cards?.manaCost) ?? "")"
        typeLabel.text = "type: \((cards?.type) ?? "")"
        rarityLabel.text = "rarity: \((cards?.rarity) ?? "")"
        textLabel.text = "text: \((cards?.text) ?? "")"
        artistLabel.text = "artist: \((cards?.artist) ?? "")"
        setLabel.text = "set: \((cards?.set) ?? "")"

        guard let imageUrl = cards?.imageUrl,
              let url = URL(string: imageUrl),
              let imageData = try? Data(contentsOf: url)
        else {
            cardImage.image = UIImage(named: "noImage")
            return
        }
        cardImage.image = UIImage(data: imageData)
    }
}
