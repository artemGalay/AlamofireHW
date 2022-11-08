//
//  DetailPresenter.swift
//  AlamofireHW
//
//  Created by Артем Галай on 7.11.22.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func showCard(model: Card?)
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    
    func showCard(model: Card?) {
        let manaCost = model?.manaCost
        let type = model?.type
        let rarity = model?.rarity
        let text = model?.text
        let artist = model?.artist
        let set = model?.set
        let imageUrl = model?.imageUrl
        
        view?.setCards(manaCost: manaCost!, type: type!, rarity: rarity!, text: text!, artist: artist!, set: set!, imageUrl: imageUrl ?? "")
    }
}
