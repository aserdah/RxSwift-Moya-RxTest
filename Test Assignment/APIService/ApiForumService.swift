//
//  ApiForumService.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 24/06/2022.
//

import Moya

enum ApiForumService {
    
    case login(q: String,page: Int)
}

extension ApiForumService: TargetType {
    
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
            
        case .login:
            return "/search/users"
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let q,let page):
            var params: [String: Any] = [:]
            params["q"] = q
            params["page"] = page
            params["per_page"] = 9
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
