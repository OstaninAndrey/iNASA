//
//  EndPointType.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation

public protocol EndPointType {
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask {get}
    var headers: HTTPHeaders? {get}
}
