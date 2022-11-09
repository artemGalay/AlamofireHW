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
}

final class MainPresenter: MainPresenterProtocol {

    //MARK: - Property

    private weak var view: MainViewProtocol?
    private var cards: [Card] = []
    private var cardsUrl = ""
    private var timer: Timer?

    // MARK: - Initialization
    
    init(view: MainViewProtocol, cards: [Card]) {
        self.view = view
        self.cards = cards
    }

    //MARK: - Funcs

    func fetchCards(url: String) {
        let request = AF.request(url)
        request.responseDecodable(of: Cards.self) { [weak self] data in
            guard let self = self else { return }
            guard let data = data.value else { return }
            let cards = data.cards
            self.cards = cards
            self.view?.reloadCardsTableView()
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
                guard let self = self else { return }
                self.cardsUrl = "https://api.magicthegathering.io/v1/cards?name=\(searchText)"
                self.fetchCards(url: self.cardsUrl)
            })
        } else {
            cardsUrl = "https://api.magicthegathering.io/v1/cards"
            fetchCards(url: cardsUrl)
        }
    }
}
