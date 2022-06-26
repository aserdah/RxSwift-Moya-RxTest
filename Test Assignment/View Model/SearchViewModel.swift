//
//  SearchViewModel.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 24/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class SearchViewModel {
    
    static let shared = SearchViewModel()
    
    var loginBehavior = BehaviorRelay<String>(value: "")
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    var loadMoreBehavior = BehaviorRelay<Bool>(value: true)
    
    private var resultsModelSubject = PublishSubject<[UserModel]>()
    
    var isSubmitButtonEnabled: Observable<Bool> {
        return loginBehavior.asObservable().map { (login) -> Bool in
            
            let isLoginEmpty = login.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            
            return !isLoginEmpty
        }
    }
    
    
    var resultsModelObservable: Observable<[UserModel]> {
        
        return resultsModelSubject
    }
    
    func fetchUsers(page: Int) -> Completable {
        loadingBehavior.accept(true)
        
        let login = loginBehavior.value
        
        return .create { [weak self] observer in
            
            ApiForumNetworkManager.shared.login(with: login, page: page)
                .subscribe(onSuccess: { result in
                    
                    guard let self = self else { return }
                    
                    self.loadingBehavior.accept(false)
                 
                    self.resultsModelSubject.onNext(self.sortResult(items: result.items))
                    if result.items.count <= 9 {
                        self.loadMoreBehavior.accept(false)
                    }
                    
                    observer(.completed)
                }, onFailure: { error in
                    self?.loadingBehavior.accept(false)
                    observer(.error(error))
                })
        }
        
        
    }
    
    func sortResult(items: [UserModel]) -> [UserModel] {
        
      
        return items.sorted { $0.login < $1.login }
    }
    
}

