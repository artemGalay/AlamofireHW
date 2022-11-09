//
//  DetailViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    var cardImage: UIImageView { get set }
    func setCards(manaCost: String, type: String, rarity: String, text: String, artist: String, set: String, imageUrl: String?)
}

final class DetailViewController: UIViewController {

    //MARK: - Properties
    
    var presenter: DetailPresenterProtocol

    // MARK: - UIElements
    
    var cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Metric.cardImageCornerRadius
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
        setupHierarchy()
        setupLayout()
    }

    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups
    
    private func setupHierarchy() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(cardImage)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            cardImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metric.cardImageTopOffset),
            cardImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metric.cardImageLeadingOffset),
            cardImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Metric.cardImageTrailingOffset),
            cardImage.heightAnchor.constraint(equalToConstant: Metric.cardImageHeightOffset),
            
            stackView.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: Metric.stackViewTopOffset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metric.stackViewLeadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Metric.stackViewTrailingOffset)
        ])
    }
}

extension DetailViewController: DetailViewProtocol {
    func setCards(manaCost: String, type: String, rarity: String, text: String, artist: String, set: String, imageUrl: String?) {
        manaCostLabel.text = manaCost
        typeLabel.text = type
        rarityLabel.text = rarity
        textLabel.text = text
        artistLabel.text = artist
        setLabel.text = set
    }
}

// MARK: - Constants

extension DetailViewController {
    struct Metric {
        static let cardImageCornerRadius: CGFloat = 15

        static let cardImageTopOffset: CGFloat = 20
        static let cardImageLeadingOffset: CGFloat = 10
        static let cardImageTrailingOffset: CGFloat = -10
        static let cardImageHeightOffset: CGFloat = 500

        static let stackViewTopOffset: CGFloat = 10
        static let stackViewLeadingOffset: CGFloat = 10
        static let stackViewTrailingOffset: CGFloat = -10
    }
}
