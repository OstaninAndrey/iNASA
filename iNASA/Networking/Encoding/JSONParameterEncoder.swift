//
//  JSONParameterEncoder.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation

// На перспективу

public struct JSONParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: K.QuieryContentType.contentType) == nil {
                urlRequest.setValue(K.QuieryContentType.json, forHTTPHeaderField: K.QuieryContentType.contentType)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
}
