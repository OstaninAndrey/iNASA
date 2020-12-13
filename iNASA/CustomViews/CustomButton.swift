//
//  CustomButton.swift
//  iNASA
//
//  Created by Андрей Останин on 09.12.2020.
//

import UIKit

class CustomButton: UIButton {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel?.textAlignment = .center
        setTitleColor(.white, for: .normal)
        setTitleColor(.systemBlue, for: .highlighted)
        
        layer.backgroundColor = UIColor.blue.cgColor
        layer.cornerRadius = 5
        
    }
    

}
