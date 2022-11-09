//
//  CardCell.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

final class CardCell: UITableViewCell {

    //MARK: - Property

    static let identifier = "CardCell"

    //MARK: - UIElements

    private let manaCostLabel = UILabel(numberOfLines: 0)

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metric.nameLabelFontSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Metric.cardImageCornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var labelStackView = UIStackView(arrangeSubview: [manaCostLabel, nameLabel],
                                                  axis: .vertical,
                                                  spacing: 5,
                                                  distribution: .fillProportionally)

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:  - PrepareForReuse

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text?.removeAll()
        manaCostLabel.text?.removeAll()
        cardImage.image = nil
    }

    // MARK: - Setups

    private func setupHierarchy() {
        addSubview(labelStackView)
        addSubview(cardImage)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metric.cardImageLeadingOffset),
            cardImage.heightAnchor.constraint(equalToConstant: Metric.cardImageHeightOffset),
            cardImage.widthAnchor.constraint(equalToConstant: Metric.cardImageWidthOffset),

            labelStackView.topAnchor.constraint(equalTo: topAnchor, constant: Metric.labelStackViewTopOffset),
            labelStackView.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: Metric.labelStackViewLeadingOffset),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metric.labelStackViewTrailingOffset),
        ])
    }

    //MARK: - Configure

    func configureCards(model: Card?) {
        
        manaCostLabel.text = model?.type
        nameLabel.text = model?.name
        DispatchQueue.global().async {
            guard let imagePath = model?.imageUrl,
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

// MARK: - Constants

extension CardCell {
    struct Metric {
        static let nameLabelFontSize: CGFloat = 18
        static let cardImageCornerRadius: CGFloat = 15

        static let cardImageLeadingOffset: CGFloat = 15
        static let cardImageHeightOffset: CGFloat = 60
        static let cardImageWidthOffset: CGFloat = 60

        static let labelStackViewTopOffset: CGFloat = 10
        static let labelStackViewLeadingOffset: CGFloat = 10
        static let labelStackViewTrailingOffset: CGFloat = -10
    }
}
