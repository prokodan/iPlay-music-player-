//
//  BaseView.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constraintViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        constraintViews()
    }
}

@objc
extension BaseView {
    
    func setupViews() {}
    
    func constraintViews() {}
    
}
