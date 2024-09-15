//
//  SearchViewModel.swift
//  iNASA
//
//  Created by Андрей Останин on 08.12.2020.
//

import Foundation
import UIKit

class CollectionViewModel {
    
    private let networkManager: NetworkManager
    private var galleryElements: [ItemViewModel] = []
    private var currentPage: Int = .init()
    private var quiery: String = .init()
    private var availableHits = K.mainTabHits
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    var count: Int {
        return galleryElements.count
    }

    func getElementVM(index: Int) -> ItemViewModel? {
        if !galleryElements.isEmpty {
            return galleryElements[index]
        } else {
            return nil
        }
    }
    
    func lastElement(is index: Int) -> Bool{
        return index == galleryElements.count-1 ? true:false
    }
    
    func fetchNewPage(for userQuiery: String?, completion: @escaping () -> Void) {
        guard availableHits > count else {
            return
        }
        
        if let q = userQuiery {
            self.quiery = q
            currentPage = 0
            galleryElements = []
        }
    
        currentPage += 1
        networkManager.getSearchResult(quiery: self.quiery, page: currentPage) { [weak self] (collection, err) in
            guard err == nil else {
                print(err!)
                return
            }
            
            collection?.items.forEach({ (item) in
                self?.galleryElements.append(ItemViewModel(item: item))
            })
            
            self?.availableHits = collection!.metadata.totalHits
            completion()
            print(self?.count as Any)
        }
        
    }
    
    func fetchMainScreen(completion: @escaping () -> Void) {
        galleryElements = []
        availableHits = K.mainTabHits
        
        networkManager.getSearchResult(quiery: "", page: 1) { [weak self] (collection, err) in
            collection?.items.forEach({ (item) in
                
                self?.galleryElements.append(ItemViewModel(item: item))
            })
            print(self?.count as Any)
            completion()
        }
    }
    
}

