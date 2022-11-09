//
//  UILabel + Extension.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

extension UILabel {
    convenience init(numberOfLines: Int?) {
        self.init()
        self.numberOfLines = numberOfLines ?? 0
        font = .systemFont(ofSize: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
