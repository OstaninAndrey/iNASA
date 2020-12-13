//
//  ThumbCellViewModel.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation
import UIKit

class ItemViewModel {
    private var item: Item
    private let nwSer = NetworkManager()
    
    var thumbnailUrl: String {
        return item.links[0].href
    }
    
    var id: String {
        return item.data[0].nasa_id
    }
    
    var description: String {
        return item.data[0].description
    }
    
    var title: String {
        return item.data[0].title
    }
    
    var location: String {
        item.data[0].location ?? "---"
    }
    
    var dateCreated: String {
        item.data[0].date_created
    }
    
    init(item: Item) {
        self.item = item
    }
    
    convenience init(article: Article) {
        let item = Item(links: [Link(render: "",
                                     href: article.imgHref!,
                                     rel: "")],
                        href: "",
                        data: [ItemData(media_type: "",
                                        nasa_id: article.id!,
                                        description: article.descriptionText!,
                                        date_created: article.date!,
                                        location: nil,
                                        title: article.title!)])
    
        self.init(item: item)
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let safeData = DatabaseHelper.shared.tryToFetchArticle(with: id) {
            completion(UIImage(data: safeData)!)
//            print("Took from db")
        } else {
            nwSer.loadImage(stringUrl: thumbnailUrl) { (image, error) in
                completion(image)
            }
        }
        
    }
    
    func buttonHidden() -> Bool {
        if let _ = DatabaseHelper.shared.tryToFetchArticle(with: id) {
            return true
        }
        return false
    }
    
}
