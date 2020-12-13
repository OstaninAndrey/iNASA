//
//  SavedTableViewCell.swift
//  iNASA
//
//  Created by Андрей Останин on 09.12.2020.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    @IBOutlet private var backView: UIView!
    @IBOutlet private var previewImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    func configure(item: Article) {
        previewImage.image = UIImage(data: item.image!)
        titleLabel.text = item.title
        locationLabel.text = item.id
        dateLabel.text = item.date
    }
}
    
