//
//  UIButton+Extension.swift
//  Map
//
//  Created by Дмитрий Скок on 26.12.2022.
//

import UIKit

extension UIButton{
    
    convenience init(title: String,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     fount: UIFont = .boldSystemFont(ofSize: 20),
                     cornerRadius: CGFloat = 15,
                     borderWidth: CGFloat = 2,
                     borderColor: CGColor,
                     isHidden: Bool) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = fount
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.isHidden = isHidden
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
