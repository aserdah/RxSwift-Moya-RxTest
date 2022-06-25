//
//  ApiForumNetworkManager.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 24/06/2022.
//

import RxSwift
import Moya

struct ApiForumNetworkManager {
    
    //a singleton
    static let shared = ApiForumNetworkManager()
    
    
    private let provider = MoyaProvider<ApiForumService>()
    
    private init() {}
    
    func login(with login: String, page: Int) -> Single<ResultsModel> {
        
        return provider.rx
            .request(.login(q: login, page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(ResultsModel.self)
        
    }
}

