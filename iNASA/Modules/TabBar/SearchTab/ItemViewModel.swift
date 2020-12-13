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
    private let networkManager = NetworkManager()
    
    var thumbnailUrl: String {
        return item.links.first?.href ?? ""
    }
    
    var id: String {
        return item.data.first?.nasaId ?? ""
    }
    
    var description: String {
        return item.data.first?.description ?? ""
    }
    
    var title: String {
        return item.data.first?.title ?? ""
    }
    
    var dateCreated: String {
        item.data.first?.dateCreated ?? ""
    }
    
    init(item: Item) {
        self.item = item
    }
    
    convenience init(article: Article) {
        let item = Item(links: [Link(render: "",
                                     href: article.imgHref ?? "",
                                     rel: "")],
                        href: "",
                        data: [ItemData(mediaType: "",
                                        nasaId: article.id ?? "",
                                        description: article.descriptionText ?? "",
                                        dateCreated: article.date ?? "",
                                        title: article.title ?? "")
                        ]
        )
    
        self.init(item: item)
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let safeData = DatabaseHelper.shared.tryToFetchArticle(with: id),
           let image = UIImage(data: safeData) {
            
            completion(image)
        } else {
            networkManager.loadImage(stringUrl: thumbnailUrl) { (image, error) in
                completion(image)
            }
        }
        
    }
    
    func buttonHiddenState() -> Bool {
        if let _ = DatabaseHelper.shared.tryToFetchArticle(with: id) {
            return true
        }
        return false
    }
    
}