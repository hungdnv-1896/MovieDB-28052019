//
//  MovieDetailViewModelTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class MovieDetailViewModelTests: XCTestCase {
    private var viewModel: MovieDetailViewModel!
    private var navigator: MovieDetailNavigatorMock!
    private var useCase: MovieDetailUseCaseMock!
    
    private var input: MovieDetailViewModel.Input!
    private var output: MovieDetailViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let showCastDetailTrigger = PublishSubject<IndexPath>()
    private let backScreenTrigger = PublishSubject<Void>()
    private let showReviewsTrigger = PublishSubject<Void>()
    private let playTrailerTrigger = PublishSubject<Void>()
    private let addFavoriteTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = MovieDetailNavigatorMock()
        useCase = MovieDetailUseCaseMock()
        viewModel = MovieDetailViewModel(useCase: useCase,
                                         navigator: navigator,
                                         movie: Movie()
                                        )
        disposeBag = DisposeBag()
        input = MovieDetailViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            showCastDetailTrigger: showCastDetailTrigger.asDriverOnErrorJustComplete(),
            backScreenTrigger: backScreenTrigger.asDriverOnErrorJustComplete(),
            showReviewsTrigger: showReviewsTrigger.asDriverOnErrorJustComplete(),
            playTrailerTrigger: playTrailerTrigger.asDriverOnErrorJustComplete(),
            addFavoriteTrigger: loadTrigger.asDriverOnErrorJustComplete()
        )
        output = viewModel.transform(input)
        output.movieDetail.drive().disposed(by: disposeBag)
        output.castList.drive().disposed(by: disposeBag)
        output.backScreen.drive().disposed(by: disposeBag)
        output.showCastDetail.drive().disposed(by: disposeBag)
        output.showReviews.drive().disposed(by: disposeBag)
        output.playTrailer.drive().disposed(by: disposeBag)
        output.addFavorite.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getMovieDetail() {
        loadTrigger.onNext(())
        let movieDetail = try? output.movieDetail.toBlocking(timeout: 1).first()
        let castList = try? output.castList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMovieDetailCalled)
        XCTAssertNotNil(movieDetail)
        XCTAssertEqual(castList?.count, 1)
    }
    
    func test_showCastDetailTrigger_toCastDetail() {
        loadTrigger.onNext(())
        showCastDetailTrigger.onNext(IndexPath(row: 0, section: 0))
        XCTAssert(navigator.toCastDetailCalled)
    }
    
    func test_backScreenTrigger_backScreen() {
        loadTrigger.onNext(())
        backScreenTrigger.onNext(())
        XCTAssert(navigator.backScreenCalled)
    }
    
    func test_showReviewsTrigger_toReviews() {
        loadTrigger.onNext(())
        showReviewsTrigger.onNext(())
        
        XCTAssert(navigator.toReviewsCalled)
    }
    
    func test_playTrailerTrigger_playTrailer() {
        loadTrigger.onNext(())
        playTrailerTrigger.onNext(())
        XCTAssert(navigator.playTrailerCalled)
    }
    
    func test_addFavoriteTrigger_addMovieFavorite() {
        loadTrigger.onNext(())
        addFavoriteTrigger.onNext(())
        XCTAssert(useCase.addMovieFavoriteCalled)
    }
}
