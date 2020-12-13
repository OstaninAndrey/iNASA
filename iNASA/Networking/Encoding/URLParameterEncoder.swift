//
//  URLParameterEncoder.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let quieryItem = URLQueryItem(name: key,
                                              value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(quieryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: K.QuieryContentType.contentType) == nil {
            urlRequest.setValue(K.QuieryContentType.encodedUTF8, forHTTPHeaderField: K.QuieryContentType.contentType)
        }
    }
    
    
}
