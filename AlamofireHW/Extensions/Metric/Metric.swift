//
//  Metric.swift
//  AlamofireHW
//
//  Created by Артем Галай on 3.11.22.
//

import UIKit

//MARK: - MetricMainViewController

extension MainViewController {
    struct MetricMainViewController {

        static let searchButtonImage: UIImage = UIImage(named: "searchButton") ?? UIImage()
//        static let allCardsUrl = "https://api.magicthegathering.io/v1/cards"
        static let heightCell: CGFloat = 70

        static let searchBarTopAnchorConstraint: CGFloat = 10
        static let searchBarLeadingAnchorConstraint: CGFloat = 10
        static let searchBarTrailingAnchorConstraint: CGFloat = -10
        static let searchBarHeightAnchorConstraint: CGFloat = 40

        static let searchButtonLeadingAnchorConstraint: CGFloat = 5
        static let searchButtonTrailingAnchorConstraint: CGFloat = -10
        static let searchButtonHeightAnchorConstraint: CGFloat = 40

        static let cardsTableViewTopAnchorConstraint: CGFloat = 0
        static let cardsTableViewBottomAnchorConstraint: CGFloat = 0
        static let cardsTableViewLeadingAnchorConstraint: CGFloat = 0
        static let cardsTableViewTrailingAnchorConstraint: CGFloat = 0
    }
}

//MARK: - MetricCardCell

extension CardCell {
    struct MetricCardCell {

        static let nameLabelFontSize: CGFloat = 18
        static let cardImageCornerRadius: CGFloat = 15

        static let cardImageLeadingAnchorConstraint: CGFloat = 15
        static let cardImageHeightAnchorConstraint: CGFloat = 60
        static let cardImageWidthAnchorConstraint: CGFloat = 60

        static let labelStackViewTopAnchorConstraint: CGFloat = 10
        static let labelStackViewLeadingAnchorConstraint: CGFloat = 10
        static let labelStackViewTrailingAnchorConstraint: CGFloat = -10
    }
}

//MARK: - MetricDetailViewController

extension DetailViewController {
    struct MetricDetailViewController {
        
        static let cardImageCornerRadius: CGFloat = 15

        static let cardImageTopAnchorConstraint: CGFloat = 20
        static let cardImageLeadingAnchorConstraint: CGFloat = 10
        static let cardImageTrailingAnchorConstraint: CGFloat = -10
        static let cardImageHeightAnchorConstraint: CGFloat = 500

        static let stackViewTopAnchorConstraint: CGFloat = 10
        static let stackViewLeadingAnchorConstraint: CGFloat = 10
        static let stackViewTrailingAnchorConstraintv: CGFloat = -10
    }
}
