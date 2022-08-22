//
//  UIView+Extension.swift
//  WalletChallenge
//
//  Created by Ivan Valero on 03/08/2022.
//

import Foundation
import UIKit

class StyleUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
        setupView()
    }
    
    private func setupView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
//        layer.cornerRadius = 4
        layer.shadowOpacity = 0.1
        cornerRadiusV = 4
    }
    
    
}

extension UIView {
    @IBInspectable var cornerRadiusV: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
}
