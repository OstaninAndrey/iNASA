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

struct Metadata {
    let totalHits: Int
}

extension Metadata: Decodable {
    private enum metadataCodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: metadataCodingKeys.self)
            
        totalHits = try container.decode(Int.self, forKey: .totalHits)
    }
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

struct ItemData {
    let mediaType: String
    let nasaId: String
    let description: String
    let dateCreated: String
    let title: String
}

extension ItemData: Decodable {
    private enum ItemDataCodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case nasaId = "nasa_id"
        case description = "description"
        case dateCreated = "date_created"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemDataCodingKeys.self)
            
        mediaType = try container.decode(String.self, forKey: .mediaType)
        nasaId = try container.decode(String.self, forKey: .nasaId)
        description = try container.decode(String.self, forKey: .description)
        dateCreated = try container.decode(String.self, forKey: .dateCreated)
        title = try container.decode(String.self, forKey: .title)
    }
}
