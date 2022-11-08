//
//  MainPresenter.swift
//  AlamofireHW
//
//  Created by Артем Галай on 7.11.22.
//

import Foundation
import Alamofire

//MARK: - MainPresenterProtocol

protocol MainPresenterProtocol: AnyObject {
    func fetchCards(url: String)
    func returnCardsCount() -> Int
    func getUsedCards(at row: Int) -> Card
    func searchCard(searchText: String)
    //    func configureCardsForCell(model: Card?)
}

class MainPresenter: MainPresenterProtocol {

    //MARK: - Property

    weak var view: MainViewProtocol?
    var cards: [Card] = []
    var cardsUrl = ""
    private var timer: Timer?

    //MARK: - Init

    required init(view: MainViewProtocol, cards: [Card]) {
        self.view = view
        self.cards = cards
    }

    //MARK: - Funcs

    func fetchCards(url: String) {
        let request = AF.request(url)
        request.responseDecodable(of: Cards.self) { [weak self] data in
            guard let data = data.value else { return }
            let cards = data.cards
            self?.cards = cards
            self?.view?.reloadCardsTableView()
        }
    }

    func returnCardsCount() -> Int {
        cards.count
    }

    func getUsedCards(at row: Int) -> Card {
        cards[row]
    }

    func searchCard(searchText: String) {

        if !searchText.isEmpty {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.cardsUrl = "https://api.magicthegathering.io/v1/cards?name=\(searchText)"
                self?.fetchCards(url: self?.cardsUrl ?? "")
            })
        } else {
            cardsUrl = "https://api.magicthegathering.io/v1/cards"
            fetchCards(url: cardsUrl)
        }
    }

//    func configureCardsForCell(model: Card?) {
//        manaCostLabel.text = model?.type
//        nameLabel.text = model?.name
//        DispatchQueue.global().async {
//            guard let imagePath = model?.imageUrl,
//                  let imageURL = URL(string: imagePath),
//                  let imageData = try? Data(contentsOf: imageURL) else {
//                DispatchQueue.main.async {
//                    self.cardImage.image = UIImage(named: "noImage")
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                self.cardImage.image = UIImage(data: imageData)
//            }
//        }
//    }

}
