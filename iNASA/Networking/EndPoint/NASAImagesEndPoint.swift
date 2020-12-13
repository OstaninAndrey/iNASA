//
//  ImagesEndPoint.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation

public enum NASAImageLibraryAPI {
    
    case image(url: String)
    
    case search(quiery: String,
                page: Int,
                mediaType: String = "image")
}

extension NASAImageLibraryAPI: EndPointType {
    
    var stringBaseURL: String {
        switch self {
        case .image(let url):
            let safeUrl = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            return safeUrl ?? url
        default:
            return K.Path.basePath
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: stringBaseURL) else {
            print(stringBaseURL)
            fatalError()
        }
        
        return url
    }
    
    public var path: String {
        switch self {
        case .search:
            return K.Path.search
        case .image:
            return K.Path.empty
        }
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        switch self {
            
        case .search(let quiery, let page, let mediaType):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        K.ParameterOptions.quiery: quiery,
                                        K.ParameterOptions.page: page,
                                        K.ParameterOptions.mediaType: mediaType
                                      ])
        case .image:
            return .request
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
