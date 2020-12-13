//
//  ThumbCell.swift
//  iNASA
//
//  Created by Андрей Останин on 08.12.2020.
//

import UIKit

class ThumbCell: UICollectionViewCell {
    
    @IBOutlet private var backView: UIView!
    @IBOutlet private var thumbImage: UIImageView!
    private var itemVM: ItemViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemVM?.cancelImageLoading()
        thumbImage.image = nil
        itemVM = nil
    }
    
    func configure(itemVM: ItemViewModel) {
        self.itemVM = itemVM
        
        itemVM.loadImage() { (img) in
            guard let safeImg = img else {
                return
            }
            DispatchQueue.main.async {
                self.thumbImage.image = safeImg
            }
        }
    }

}
