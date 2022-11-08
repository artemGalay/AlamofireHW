//
//  DetailViewController.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setCards(manaCost: String, type: String, rarity: String, text: String, artist: String, set: String, imageUrl: String?)
}

final class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol

    // MARK: - UIElements
    
    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = MetricDetailViewController.cardImageCornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let manaCostLabel = UILabel(numberOfLines: 2)
    
    let typeLabel = UILabel(numberOfLines: 3)
    
    let rarityLabel = UILabel(numberOfLines: 1)
    
    let textLabel = UILabel(numberOfLines: 10)
    
    let artistLabel = UILabel(numberOfLines: 1)
    
    let setLabel = UILabel(numberOfLines: 1)
    
    lazy var stackView = UIStackView(arrangeSubview: [manaCostLabel,
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

    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension DetailViewController: DetailViewProtocol {
    func setCards(manaCost: String, type: String, rarity: String, text: String, artist: String, set: String, imageUrl: String?) {
        manaCostLabel.text = manaCost
        typeLabel.text = type
        rarityLabel.text = rarity
        textLabel.text = text
        artistLabel.text = artist
        setLabel.text = set
        
        DispatchQueue.global().async {
            guard let imagePath = imageUrl,
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
