//
//  SearchViewModelTests.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 25/06/2022.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import Test_Assignment

class SearchViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    var searchViewModel: SearchViewModel!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!
    
    fileprivate var service : ApiForumService!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        searchViewModel = SearchViewModel()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        disposeBag = nil
        searchViewModel = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }
    // MARK: - RxTest

    func testButtonIsDisabled() {
        let isSubmitButtonEnabled = testScheduler.createObserver(Bool.self)

        searchViewModel = SearchViewModel()
        searchViewModel.isSubmitButtonEnabled
            .bind(to: isSubmitButtonEnabled)
            .disposed(by: DisposeBag())
        XCTAssertRecordedElements(isSubmitButtonEnabled.events, [false])

        }
        
        func testButtonIsEnabled() {
            let isSubmitButtonEnabled = testScheduler.createObserver(Bool.self)

            searchViewModel = SearchViewModel()
            searchViewModel.loginBehavior.accept("dd")
            searchViewModel.isSubmitButtonEnabled
                .bind(to: isSubmitButtonEnabled)
                .disposed(by: DisposeBag())
            XCTAssertRecordedElements(isSubmitButtonEnabled.events, [true])

        }
    

        func testFetchData() {
            let isFetchData = testScheduler.createObserver(Bool.self)
            searchViewModel.loginBehavior.accept("sd")
            searchViewModel.fetchUsers(page: 1)
                .subscribe(onCompleted: { [weak self]  in
                   
                    XCTAssertRecordedElements(isFetchData.events, [true])
                }, onError: { [weak self] error in
                    XCTFail(error.localizedDescription)
                  
                })
                .disposed(by: disposeBag)
                   
            testScheduler.start()
                   
    
        }
    func testFetchDataWithError() {
        let isFetchData = testScheduler.createObserver(Bool.self)
        searchViewModel.fetchUsers(page: 1)
            .subscribe(onCompleted: { [weak self]  in
               
                XCTAssertRecordedElements(isFetchData.events, [true])
            }, onError: { [weak self] error in
                XCTFail(error.localizedDescription)
              
            })
            .disposed(by: disposeBag)
               
        testScheduler.start()
               

    }
}
