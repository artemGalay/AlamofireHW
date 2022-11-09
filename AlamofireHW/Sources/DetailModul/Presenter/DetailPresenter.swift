//
//  DetailPresenter.swift
//  AlamofireHW
//
//  Created by Артем Галай on 7.11.22.
//

import UIKit

protocol DetailPresenterProtocol: AnyObject {
    func showCard(model: Card?)
}

final class DetailPresenter: DetailPresenterProtocol {

    //MARK: - Properties

    private var cardsUrl = "https://api.magicthegathering.io/v1/cards"
    weak var view: DetailViewProtocol?

    //MARK: - func showCard()

    func showCard(model: Card?) {
        let manaCost = model?.manaCost
        let type = model?.type
        let rarity = model?.rarity
        let text = model?.text
        let artist = model?.artist
        let set = model?.set
        let imageUrl = model?.imageUrl

        DispatchQueue.global().async {
            guard let imagePath = imageUrl,
                  let imageURL = URL(string: imagePath),
                  let imageData = try? Data(contentsOf: imageURL) else {
                DispatchQueue.main.async {
                    self.view?.cardImage.image = UIImage(named: "noImage") ?? UIImage()
                }
                return
            }
            DispatchQueue.main.async {
                self.view?.cardImage.image = UIImage(data: imageData) ?? UIImage()
            }
        }
        
        view?.setCards(manaCost: manaCost ?? "",
                       type: type ?? "",
                       rarity: rarity ?? "",
                       text: text ?? "",
                       artist: artist ?? "",
                       set: set ?? "",
                       imageUrl: imageUrl)
    }
}
