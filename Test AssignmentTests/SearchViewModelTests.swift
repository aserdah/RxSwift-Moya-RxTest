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
        func testWhenInitialStateSubmitButtonIsDisabled() {
            let isSubmitButtonEnabled = testScheduler.createObserver(Bool.self)
        
            searchViewModel.isSubmitButtonEnabled
                .bind(to: isSubmitButtonEnabled)
                .disposed(by: DisposeBag())

            XCTAssertRecordedElements(isSubmitButtonEnabled.events, [false])
        
        }
    
}
