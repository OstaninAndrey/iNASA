//
//  QuieryModel.swift
//  iNASA
//
//  Created by Андрей Останин on 10.12.2020.
//

import Foundation

struct Collection: Decodable {
    let collection: CollectionModel
}


struct CollectionModel: Decodable {
    let version: String?
    let metadata: Metadata
    let href: String?
    let items: [Item]
}

struct Metadata: Decodable {
    let total_hits: Int
}
 
struct Item: Decodable {
    let links: [Link]
    let href: String
    let data: [ItemData]
}

struct Link: Decodable {
    let render: String
    let href: String
    let rel: String
}

struct ItemData: Decodable {
    let media_type: String
    let nasa_id: String
    let description: String
    let date_created: String
    let location: String?
    let title: String
}
