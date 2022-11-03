//
//  CardCell.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

class CardCell: UITableViewCell {

    static let identifier = "CardCell"

    var card: Card? {
        didSet {
            manaCostLabel.text = card?.type
            nameLabel.text = card?.name
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

    private let manaCostLabel = UILabel(numberOfLines: 0)

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(nameLabel)
        addSubview(manaCostLabel)
        addSubview(cardImage)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cardImage.heightAnchor.constraint(equalToConstant: 60),
            cardImage.widthAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: manaCostLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            manaCostLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            manaCostLabel.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10),
            manaCostLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
