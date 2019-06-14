//
//  CastDetailViewModelTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class CastDetailViewModelTests: XCTestCase {
    private var viewModel: CastDetailViewModel!
    private var navigator: CastDetailNavigatorMock!
    private var useCase: CastDetailUseCaseMock!
    
    private var input: CastDetailViewModel.Input!
    private var output: CastDetailViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let backScreenTrigger = PublishSubject<Void>()
    private let selectMovieTrigger = PublishSubject<IndexPath>()
    
    override func setUp() {
        super.setUp()
        navigator = CastDetailNavigatorMock()
        useCase = CastDetailUseCaseMock()
        viewModel = CastDetailViewModel(useCase: useCase,
                                        navigator: navigator,
                                        cast: Cast())
        disposeBag = DisposeBag()
        input = CastDetailViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            backScreenTrigger: backScreenTrigger.asDriverOnErrorJustComplete(),
            selectMovieTrigger: selectMovieTrigger.asDriverOnErrorJustComplete()
        )
        output = viewModel.transform(input)
        output.castDetail.drive().disposed(by: disposeBag)
        output.movieList.drive().disposed(by: disposeBag)
        output.backScreen.drive().disposed(by: disposeBag)
        output.selectedMovie.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getCastDetail() {
        loadTrigger.onNext(())
        let castDetail = try? output.castDetail.toBlocking(timeout: 1).first()
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getCastDetailCalled)
        XCTAssert(useCase.getMovieListByCastCalled)
        XCTAssertNotNil(castDetail)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_backScreenTriggerInvoked_backScreen() {
        loadTrigger.onNext(())
        backScreenTrigger.onNext(())
        XCTAssert(navigator.backScreenCalled)
    }
    
    func test_selectMovieTriggerInvoked_toMovieDetail() {
        loadTrigger.onNext(())
        selectMovieTrigger.onNext(IndexPath(row: 0, section: 0))
        XCTAssert(navigator.toMovieDetailCalled)
    }
}
