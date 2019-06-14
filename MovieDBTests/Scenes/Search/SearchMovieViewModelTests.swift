//
//  SearchMovieViewModelTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import RxSwift
import XCTest

final class SearchMovieViewModelTests: XCTestCase {
    private var viewModel: SearchMovieViewModel!
    private var navigator: SearchMovieNavigatorMock!
    private var useCase: SearchMovieUseCaseMock!
    
    private var input: SearchMovieViewModel.Input!
    private var output: SearchMovieViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private var loadTrigger = PublishSubject<String>()
    private var reloadTrigger = PublishSubject<Void>()
    private var loadMoreTrigger = PublishSubject<Void>()
    private var selectMovieTrigger = PublishSubject<IndexPath>()
    
    override func setUp() {
        super.setUp()
        navigator = SearchMovieNavigatorMock()
        useCase = SearchMovieUseCaseMock()
        viewModel = SearchMovieViewModel(useCase: useCase, navigator: navigator)
        
        input = SearchMovieViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
            loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete(),
            selectMovieTrigger: selectMovieTrigger.asDriverOnErrorJustComplete()
        )
        
        output = viewModel.transform(input)
        
        disposeBag = DisposeBag()
        
        output.error.drive().disposed(by: disposeBag)
        output.loading.drive().disposed(by: disposeBag)
        output.refreshing.drive().disposed(by: disposeBag)
        output.loadingMore.drive().disposed(by: disposeBag)
        output.fetchItems.drive().disposed(by: disposeBag)
        output.movieList.drive().disposed(by: disposeBag)
        output.selectedMovie.drive().disposed(by: disposeBag)
        output.isEmptyData.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_searchMovie() {
        loadTrigger.onNext("")
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.searchMoiveCalled)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_loadTriggerInvoked_failedShowError() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext(" ")
        searchMovieReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.searchMoiveCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_searchMovie() {
        loadTrigger.onNext("")
        reloadTrigger.onNext(())
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.searchMoiveCalled)
        XCTAssertEqual(movieList?.count, 1)
    }
    
    func test_reloadTriggerInvoked_searchMovie_failedShowError() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext("")
        reloadTrigger.onNext(())
        searchMovieReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.searchMoiveCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_notSearchMovieIfStillLoading() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext("")
        useCase.searchMoiveCalled = false
        reloadTrigger.onNext(())
        
        XCTAssert(useCase.searchMoiveCalled)
    }
    
    func test_reloadMovieTriggerInvoked_notSearchMovieStillReloading() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext("")
        reloadTrigger.onNext(())
        useCase.searchMoiveCalled = false
        reloadTrigger.onNext(())
        
        XCTAssertFalse(useCase.searchMoiveCalled)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreSearchMovie() {
        loadTrigger.onNext("")
        loadMoreTrigger.onNext(())
        let movieList = try? output.movieList.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreSearchMoviewCalled)
        XCTAssertEqual(movieList?.count, 2)
    }
    
    func test_loadMoreTriggerInvoked_loadMoreSearchMovie_failedShowError() {
        let loadMoreSearchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.loadMoreSearchMovieReturnValue = loadMoreSearchMovieReturnValue
        
        loadTrigger.onNext("")
        loadMoreTrigger.onNext(())
        loadMoreSearchMovieReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        XCTAssert(useCase.loadMoreSearchMoviewCalled)
        XCTAssert(error is TestError)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreSearchMovieIfStillLoading() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        loadTrigger.onNext("")
        useCase.searchMoiveCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.searchMoiveCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreMovieListIfStillReloading() {
        let searchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.searchMovieReturnValue = searchMovieReturnValue
        
        reloadTrigger.onNext(())
        useCase.searchMoiveCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreSearchMoviewCalled)
    }
    
    func test_loadMoreTriggerInvoked_notLoadMoreDocumentTypesStillLoadingMore() {
        let loadMoreSearchMovieReturnValue = PublishSubject<PagingInfo<Movie>>()
        useCase.loadMoreSearchMovieReturnValue = loadMoreSearchMovieReturnValue
        
        loadMoreTrigger.onNext(())
        useCase.loadMoreSearchMoviewCalled = false
        loadMoreTrigger.onNext(())
        
        XCTAssertFalse(useCase.loadMoreSearchMoviewCalled)
    }
    
    func test_selectMovieTriggerInvoked_toMovieDetail() {
        loadTrigger.onNext("")
        selectMovieTrigger.onNext(IndexPath(row: 0, section: 0))
        XCTAssert(navigator.toMovieDetailCalled)
    }
}
