//
//  CustomButton.swift
//  iNASA
//
//  Created by Андрей Останин on 09.12.2020.
//

import UIKit

class CustomButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        titleLabel?.font = UIFont.systemFont(ofSize: K.FontSize.large, weight: .bold)
        titleLabel?.textAlignment = .center
        setTitleColor(.white, for: .normal)
        setTitleColor(.systemBlue, for: .highlighted)
        
        layer.backgroundColor = UIColor.blue.cgColor
        layer.cornerRadius = 5
    }
    
}
