//
//  UIView + extension.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import UIKit

extension UIView {
    
    func addView(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
