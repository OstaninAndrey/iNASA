//
//  Constants.swift
//  iNASA
//
//  Created by Андрей Останин on 10.12.2020.
//

import Foundation
import UIKit

public struct K {
    struct ThumbCell {
        static let nibName = "ThumbCell"
        static let reuseID = "ThumbCell"
    }
    
    struct SavedCell {
        static let nibName = "SavedTableViewCell"
        static let reuseID = "SavedTableViewCell"
    }
    
    static let containerName = "Cache"
    static let containerName2 = "TestChange11111"
    
    struct MediaType {
        static let image = "image"
    }
    
    struct Path {
        static let basePath = "https://images-api.nasa.gov/"
        static let search = "search"
        static let empty = ""
    }
    
    struct ParameterOptions {
        static let quiery = "q"
        static let page = "page"
        static let mediaType = "media_type"
    }
    
    struct EntityName {
        static let article = "Article"
    }
    
    struct QuieryContentType {
        static let contentType = "Content-Type"
        static let json = "application/json"
        static let encodedUTF8 = "application/x-www-form-urlencoded; charset=utf-8"
    }
    
    struct TabBar {
        static let mainTabName = "NASA Search"
        static let downloadsTabName = "Downloads"
    }
    
    struct Image {
        static let mainTab = "searchTab"
        static let downloads = "loadsTab"
    }
    
    static let mainTabHits = 101
    
    struct ButtonTitle {
        static let search = "Find"
        static let save = "Save"
    }
    
    struct FontSize {
        static let small: CGFloat = 15
        static let medium: CGFloat = 18
        static let large: CGFloat = 20
    }
}
