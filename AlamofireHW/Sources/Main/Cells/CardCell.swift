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
        label.font = .systemFont(ofSize: MetricCardCell.nameLabelFontSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = MetricCardCell.cardImageCornerRadius
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
            cardImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricCardCell.cardImageLeadingAnchorConstraint),
            cardImage.heightAnchor.constraint(equalToConstant: MetricCardCell.cardImageHeightAnchorConstraint),
            cardImage.widthAnchor.constraint(equalToConstant: MetricCardCell.cardImageWidthAnchorConstraint),

            labelStackView.topAnchor.constraint(equalTo: topAnchor, constant: MetricCardCell.labelStackViewTopAnchorConstraint),
            labelStackView.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: MetricCardCell.labelStackViewLeadingAnchorConstraint),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: MetricCardCell.labelStackViewTrailingAnchorConstraint),
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
