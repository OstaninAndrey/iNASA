//
//  SavedTableViewCell.swift
//  iNASA
//
//  Created by Андрей Останин on 09.12.2020.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configure(item: Article) {
        previewImage.image = UIImage(data: item.image!)
        titleLabel.text = item.title
        locationLabel.text = item.id
        dateLabel.text = item.date
        
    }
}
    
