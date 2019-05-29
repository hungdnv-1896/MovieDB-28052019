//
//  AppViewModelTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class AppViewModelTest: XCTestCase {
    
    private var viewModel: AppViewModel!
    private var navigator: AppNavigatorMock!
    private var useCase: AppUseCaseMock!
    
    private var input: AppViewModel.Input!
    private var output: AppViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = AppNavigatorMock()
        useCase = AppUseCaseMock()
        viewModel = AppViewModel(navigator: navigator, useCase: useCase)
        disposeBag = DisposeBag()
        input = AppViewModel.Input (loadTrigger: loadTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)
        output.toMain.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_toMain() {
        // act
        loadTrigger.onNext(())
        
        // assert
        XCTAssert(navigator.toMainCalled)
    }
}
