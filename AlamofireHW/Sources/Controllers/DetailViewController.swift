//
//  DetailViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

final class DetailViewController: UIViewController {

    //MARK: - Property

    var card: Card? {
        didSet {
            manaCostLabel.text = "manaCost: \((card?.manaCost) ?? "")"
            typeLabel.text = "type: \((card?.type) ?? "")"
            rarityLabel.text = "rarity: \((card?.rarity) ?? "")"
            textLabel.text = "text: \((card?.text) ?? "")"
            artistLabel.text = "artist: \((card?.artist) ?? "")"
            setLabel.text = "set: \((card?.set) ?? "")"
            
            DispatchQueue.global().async {
                guard let imagePath = self.card?.imageUrl,
                      let imageURL = URL(string: imagePath),
                      let imageData = try? Data(contentsOf: imageURL) else {
                    DispatchQueue.main.async {
                        self.cardImage.image = UIImage(named: "noImage")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.cardImage.image = UIImage(data: imageData)
                }
            }
        }
    }

    // MARK: - UIElements

    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = MetricDetailViewController.cardImageCornerRadius
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
    }

    // MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(stackView)
        view.addSubview(cardImage)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            cardImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: MetricDetailViewController.cardImageTopAnchorConstraint),
            cardImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MetricDetailViewController.cardImageLeadingAnchorConstraint),
            cardImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: MetricDetailViewController.cardImageTrailingAnchorConstraint),
            cardImage.heightAnchor.constraint(equalToConstant: MetricDetailViewController.cardImageHeightAnchorConstraint),

            stackView.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: MetricDetailViewController.stackViewTopAnchorConstraint),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MetricDetailViewController.stackViewLeadingAnchorConstraint),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: MetricDetailViewController.stackViewTrailingAnchorConstraintv)
        ])
    }
}
