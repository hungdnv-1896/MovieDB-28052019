//
//  ReviewsViewModelTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class ReviewsViewModelTests: XCTestCase {
    private var viewModel: ReviewsMovieViewModel!
    private var navigator: ReviewNavigatorMock!
    private var useCase: ReviewsUseCaseMock!
    
    private var input: ReviewsMovieViewModel.Input!
    private var output: ReviewsMovieViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private var loadTrigger = PublishSubject<Void>()
    private var reloadTrigger = PublishSubject<Void>()
    private var loadMoreTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = ReviewNavigatorMock()
        useCase = ReviewsUseCaseMock()
        viewModel = ReviewsMovieViewModel(
            useCase: useCase,
            navigator: navigator,
            movie: Movie()
        )
        input = ReviewsMovieViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
            loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete()
        )
        output = viewModel.transform(input)
        disposeBag = DisposeBag()
        output.error.drive().disposed(by: disposeBag)
        output.loading.drive().disposed(by: disposeBag)
        output.refreshing.drive().disposed(by: disposeBag)
        output.loadingMore.drive().disposed(by: disposeBag)
        output.fetchItems.drive().disposed(by: disposeBag)
        output.reviewList.drive().disposed(by: disposeBag)
        output.isEmptyData.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getReviewList() {
        loadTrigger.onNext(())
        let reviewList = try? output.reviewList.toBlocking(timeout: 1).first()
        XCTAssert(useCase.getReviewListCalled)
        XCTAssertEqual(reviewList?.count, 1)
    }
    
    func test_loadTriggerInvoked_geReviewList_failedShowError() {
        let getReviewListReturnValue = PublishSubject<PagingInfo<Review>>()
        useCase.getReviewListReturnValue = getReviewListReturnValue
        
        loadTrigger.onNext(())
        getReviewListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getReviewListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_getReviewList() {
        loadTrigger.onNext(())
        reloadTrigger.onNext(())
        let movieList = try? output.reviewList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getReviewListCalled)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_reloadTriggerInvoked_getReviewList_failedShowError() {
        let getReviewListReturnValue = PublishSubject<PagingInfo<Review>>()
        useCase.getReviewListReturnValue = getReviewListReturnValue
        
        loadTrigger.onNext(())
        reloadTrigger.onNext(())
        getReviewListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getReviewListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_notGetReviewListIfStillLoading() {
        // arrange
        let getReviewListReturnValue = PublishSubject<PagingInfo<Review>>()
        useCase.getReviewListReturnValue = getReviewListReturnValue
        
        // act
        loadTrigger.onNext(())
        useCase.getReviewListCalled = false
        reloadTrigger.onNext(())
        
        // assert
        XCTAssertFalse(useCase.getReviewListCalled)
    }
    
    func test_reloadTriggerInvoked_notGetReviewListIfStillReloading() {
        // arrange
        let getReviewListReturnValue = PublishSubject<PagingInfo<Review>>()
        useCase.getReviewListReturnValue = getReviewListReturnValue
        
        // act
        reloadTrigger.onNext(())
        useCase.getReviewListCalled = false
        reloadTrigger.onNext(())
        
        // assert
        XCTAssertFalse(useCase.getReviewListCalled)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreReviewList() {
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        let reviewList = try? output.reviewList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreReviewListCalled)
        XCTAssertEqual(reviewList?.count, 2)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreReviewList_failedShowError() {
        let loadMoreMovieListReturnValue = PublishSubject<PagingInfo<Review>>()
        useCase.loadMoreReviewListReturnValue = loadMoreMovieListReturnValue
        
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        loadMoreMovieListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreReviewListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreReviewListIfStillLoading() {
        let getReviewListReturnValue = PublishSubject<PagingInfo<Review>>()
        useCase.getReviewListReturnValue = getReviewListReturnValue
        
        loadTrigger.onNext(())
        useCase.getReviewListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreReviewListCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreReviewListIfStillReloading() {
        let getReviewListReturnValue = PublishSubject<PagingInfo<Review>>()
        useCase.getReviewListReturnValue = getReviewListReturnValue
        
        reloadTrigger.onNext(())
        useCase.getReviewListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreReviewListCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreDocumentTypesStillLoadingMore() {
        let loadMoreReviewListReturnValue = PublishSubject<PagingInfo<Review>>()
        useCase.loadMoreReviewListReturnValue = loadMoreReviewListReturnValue
        
        loadMoreTrigger.onNext(())
        useCase.loadMoreReviewListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreReviewListCalled)
    }
}
