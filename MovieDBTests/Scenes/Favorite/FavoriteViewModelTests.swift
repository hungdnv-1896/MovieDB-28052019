//
//  FavoriteViewModelTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxBlocking
import RxSwift

final class FavoriteViewModelTests: XCTestCase {
    private var viewModel: FavoriteViewModel!
    private var navigator: FavoriteNavigatorMock!
    private var useCase: FavoriteUseCaseMock!
    
    private var input: FavoriteViewModel.Input!
    private var output: FavoriteViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private var loadTrigger = PublishSubject<Void>()
    private var reloadTrigger = PublishSubject<Void>()
    private var loadMoreTrigger = PublishSubject<Void>()
    private var selectMovieTrigger = PublishSubject<IndexPath>()
    private var deleteFavoriteTrigger = PublishSubject<MovieFavorite>()
    
    override func setUp() {
        super.setUp()
        navigator = FavoriteNavigatorMock()
        useCase = FavoriteUseCaseMock()
        viewModel = FavoriteViewModel(navigator: navigator,
                                      useCase: useCase)
        
        input = FavoriteViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
            loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete(),
            selectMovieTrigger: selectMovieTrigger.asDriverOnErrorJustComplete(),
            deleteFavoriteTrigger: deleteFavoriteTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)
        disposeBag = DisposeBag()
        output.error.drive().disposed(by: disposeBag)
        output.loading.drive().disposed(by: disposeBag)
        output.refreshing.drive().disposed(by: disposeBag)
        output.loadingMore.drive().disposed(by: disposeBag)
        output.fetchItems.drive().disposed(by: disposeBag)
        output.movieFavoriteList.drive().disposed(by: disposeBag)
        output.isEmptyData.drive().disposed(by: disposeBag)
        output.selectedMovie.drive().disposed(by: disposeBag)
        output.deleteFavorite.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getMovieFavoriteList() {
        loadTrigger.onNext(())
        let favoriteMovieList = try? output.movieFavoriteList.toBlocking(timeout: 1).first()
        XCTAssert(useCase.getMovieFavoriteListCalled)
        XCTAssertEqual(favoriteMovieList?.count, 1)
    }
    
    func test_loadTriggerInvoked_getMovieFavoriteList_failedShowError() {
        let getMovieFavoriteListReturnValue = PublishSubject<PagingInfo<MovieFavorite>>()
        useCase.getMovieFavoriteListReturnValue = getMovieFavoriteListReturnValue
        
        loadTrigger.onNext(())
        getMovieFavoriteListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMovieFavoriteListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_getMovieFavoriteList() {
        loadTrigger.onNext(())
        reloadTrigger.onNext(())
        let favoriteMovieList = try? output.movieFavoriteList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMovieFavoriteListCalled)
        XCTAssertEqual(favoriteMovieList?.count, 1)
    }
    
    func test_reloadTriggerInvoked_getMovieFavoriteList_failedShowError() {
        let getMovieFavoriteListReturnValue = PublishSubject<PagingInfo<MovieFavorite>>()
        useCase.getMovieFavoriteListReturnValue = getMovieFavoriteListReturnValue
        
        loadTrigger.onNext(())
        reloadTrigger.onNext(())
        getMovieFavoriteListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.getMovieFavoriteListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_notGetMovieFavoriteListIfStillLoading() {
        // arrange
        let getMovieFavoriteListReturnValue = PublishSubject<PagingInfo<MovieFavorite>>()
        useCase.getMovieFavoriteListReturnValue = getMovieFavoriteListReturnValue
        
        // act
        loadTrigger.onNext(())
        useCase.getMovieFavoriteListCalled = false
        reloadTrigger.onNext(())
        
        // assert
        XCTAssertFalse(useCase.getMovieFavoriteListCalled)
    }
    
    func test_reloadTriggerInvoked_notGetMovieFavoriteListIfStillReloading() {
        // arrange
        let getMovieFavoriteListReturnValue = PublishSubject<PagingInfo<MovieFavorite>>()
        useCase.getMovieFavoriteListReturnValue = getMovieFavoriteListReturnValue
        
        // act
        reloadTrigger.onNext(())
        useCase.getMovieFavoriteListCalled = false
        reloadTrigger.onNext(())
        
        // assert
        XCTAssertFalse(useCase.getMovieFavoriteListCalled)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreMovieFavoriteList() {
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        let favoriteMovieList = try? output.movieFavoriteList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreMovieFavoriteListCalled)
        XCTAssertEqual(favoriteMovieList?.count, 2)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreMovieFavoriteList_failedShowError() {
        let loadMoreMovieFavoriteListReturnValue = PublishSubject<PagingInfo<MovieFavorite>>()
        useCase.loadMoreMovieFavoriteListReturnValue = loadMoreMovieFavoriteListReturnValue
        
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        loadMoreMovieFavoriteListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreMovieFavoriteListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMovieFavoriteListIfStillLoading() {
        let getMovieFavoriteListReturnValue = PublishSubject<PagingInfo<MovieFavorite>>()
        useCase.getMovieFavoriteListReturnValue = getMovieFavoriteListReturnValue
        
        loadTrigger.onNext(())
        useCase.getMovieFavoriteListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.getMovieFavoriteListCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMovieFavoriteListIfStillReloading() {
        let getMovieFavoriteListReturnValue = PublishSubject<PagingInfo<MovieFavorite>>()
        useCase.getMovieFavoriteListReturnValue = getMovieFavoriteListReturnValue
        
        reloadTrigger.onNext(())
        useCase.getMovieFavoriteListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.getMovieFavoriteListCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreDocumentTypesStillLoadingMore() {
        let loadMoreMovieFavoriteListReturnValue = PublishSubject<PagingInfo<MovieFavorite>>()
        useCase.loadMoreMovieFavoriteListReturnValue = loadMoreMovieFavoriteListReturnValue
        
        loadMoreTrigger.onNext(())
        useCase.loadMoreMovieFavoriteListCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreMovieFavoriteListCalled)
    }
    
    func test_selectedMovieTrigger_toMovieDetail() {
        loadTrigger.onNext(())
        selectMovieTrigger.onNext(IndexPath(row: 0, section: 0))
        XCTAssert(navigator.toMovieDetailCalled)
    }
    
    func test_deleteFavoriteTriggerInvoked_delete() {
        loadTrigger.onNext(())
        deleteFavoriteTrigger.onNext(MovieFavorite())
        XCTAssert(useCase.deleteCalled)
    }
}
