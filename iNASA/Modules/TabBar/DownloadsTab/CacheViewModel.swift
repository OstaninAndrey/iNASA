//
//  CacheViewModel.swift
//  iNASA
//
//  Created by Андрей Останин on 12.12.2020.
//

import Foundation

class CacheViewModel {
    private var articles: [Article] = []
    
    var count: Int {
        articles.count
    }
    
    func getElem(index: Int) -> Article? {
        if !articles.isEmpty {
            return articles[index]
        } else {
            return nil
        }
    }
    
    func loadCache(completion: ()->()) {
        articles = DatabaseHelper.shared.getAllArticles()
        completion()
    }
    
    func removeAtIndex(_ index: Int) -> Bool {
        if DatabaseHelper.shared.remove(id: articles[index].id!) {
            articles.remove(at: index)
            return true
        }
        
        return false
    }
    
}
