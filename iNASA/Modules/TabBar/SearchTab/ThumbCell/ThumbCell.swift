//
//  ThumbCell.swift
//  iNASA
//
//  Created by Андрей Останин on 08.12.2020.
//

import UIKit

class ThumbCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var thumbImage: UIImageView!
    private var itemVM: ItemViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImage.image = nil
    }
    
    func configure(itemVM: ItemViewModel) {
        self.itemVM = itemVM
        
        // start loading photo
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
