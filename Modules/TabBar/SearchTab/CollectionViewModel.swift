//
//  SearchViewModel.swift
//  iNASA
//
//  Created by Андрей Останин on 08.12.2020.
//

import Foundation
import UIKit

class CollectionViewModel {
    
    private let nwSer = NetworkManager()
    private var galleryElements: [ItemViewModel] = []
    private var currPage = 0
    private var quiery = ""
    private var availableHits = 0
    
    var count: Int {
        return galleryElements.count
    }

    func getElemVM(index: Int) -> ItemViewModel? {
        if !galleryElements.isEmpty {
            return galleryElements[index]
        } else {
            return nil
        }
    }
    
    func lastElement(is index: Int) -> Bool{
        return index == galleryElements.count-1 ? true:false
    }
    
    func fetchNewPortion(for userQuiery: String?, completion: @escaping () -> Void) {
        guard availableHits > count else {
            return
        }
        
        if let q = userQuiery {
            self.quiery = q
            currPage = 0
            galleryElements = []
        }
    
        currPage += 1
        nwSer.getSearchResult(quiery: self.quiery, page: currPage) { (collection, err) in
            guard err == nil else {
                print(err!)
                return
            }
            
            collection?.items.forEach({ (item) in
                self.galleryElements.append(ItemViewModel(item: item))
            })
            
            self.availableHits = collection!.metadata.total_hits
            completion()
            print(self.count)
        }
        
    }
    
    func fetchMainScreen(completion: @escaping () -> Void) {
        galleryElements = []
        availableHits = 101
        
        nwSer.getSearchResult(quiery: "", page: 1) { (collection, err) in
            collection?.items.forEach({ (item) in
                
                self.galleryElements.append(ItemViewModel(item: item))
            })
            print(self.count)
            completion()
        }
    }
    
}

