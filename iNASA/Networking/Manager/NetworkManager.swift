//
//  NetworkManager.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation
import UIKit

class NetworkManager {
    private let router = Router<NASAImageLibraryAPI>()
    
    enum NetworkResponse: String {
        case success
        case badRequest = "Bad request"
        case failed = "Network request failed"
        case unableToDecode = "Couldn't decode the response"
        case noData = "No data in response"
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    fileprivate func handleNetworkResponce(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getSearchResult(quiery: String, page: Int, completion: @escaping (_ collection: CollectionModel?, _ error: String?) -> Void) {
        
        router.request(.search(quiery: quiery, page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, "Check network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponce(response)
                
                switch result {
                case .success:
                    
                    guard let safeData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(Collection.self, from: safeData)
                        completion(decodedData.collection, nil)
                        
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
        
    }
    
    func loadImage(stringUrl: String, completion: @escaping (_ image: UIImage?, _ error: String?) -> Void) {
        
        router.request(.image(url: stringUrl)) { (data, response, err) in
            if err != nil {
                completion(nil, "Check network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponce(response)
                
                switch result {
                case .success:
                    
                    guard let safeData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    let image = UIImage(data: safeData)
                    completion(image, nil)
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func cancelLoading() {
        router.cancel()
    }
    
}
