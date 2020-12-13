//
//  CustomSearchBar.swift
//  iNASA
//
//  Created by Андрей Останин on 09.12.2020.
//

import UIKit

class SearchTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override func draw(_ rect: CGRect) {
        
        // Style
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 0.3
        layer.cornerRadius = 5
        
        borderStyle = .line
        attributedPlaceholder = NSAttributedString(string: "Search...",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textColor = .white
        font = UIFont.systemFont(ofSize: K.FontSize.medium, weight: .black)
        
        // Drawing left line
        let startPoint = CGPoint(x: 0, y: frame.size.height)
        let endPoint = CGPoint(x: 0, y: 0)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
     
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 5
         
        layer.addSublayer(shapeLayer)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}

