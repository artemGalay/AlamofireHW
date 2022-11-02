//
//  UIStackView + Extension.swift
//  AlamofireHW
//
//  Created by Артем Галай on 2.11.22.
//

import UIKit

extension UIStackView {
    convenience init(arrangeSubview: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangeSubview)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
