//
//  MoviesViewModelTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking

final class MoviesViewModelTests: XCTestCase {
    private var viewModel: MoviesViewModel!
    private var navigator: MoviesNavigatorMock!
    private var useCase: MoviesUseCaseMock!
    
    private var input: MoviesViewModel.Input!
    private var output: MoviesViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let selectedCategoryTrigger = PublishSubject<IndexPath>()
    private let searchMovieTrigger = PublishSubject<Void>()
    private let selectedBannerTrigger = PublishSubject<IndexPath>()
    private let selectedMovieTrigger = PublishSubject<Movie>()
    
    override func setUp() {
        super.setUp()
        navigator = MoviesNavigatorMock()
        useCase = MoviesUseCaseMock()
        viewModel = MoviesViewModel(navigator: navigator, useCase: useCase)
        disposeBag = DisposeBag()
        input = MoviesViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            selectedCategoryTrigger: selectedCategoryTrigger.asDriverOnErrorJustComplete(),
            searchMovieTrigger: searchMovieTrigger.asDriverOnErrorJustComplete(),
            selectedBannerTrigger: selectedBannerTrigger.asDriverOnErrorJustComplete(),
            selectedMovieTrigger: selectedMovieTrigger.asDriverOnErrorJustComplete()
        )
        output = viewModel.transform(input)
        output.movieCategoryList.drive().disposed(by: disposeBag)
        output.movieBannerList.drive().disposed(by: disposeBag)
        output.selectedCategory.drive().disposed(by: disposeBag)
        output.searchMovie.drive().disposed(by: disposeBag)
        output.selectedBanner.drive().disposed(by: disposeBag)
        output.selectedMovie.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getMovieList() {
        // act
        loadTrigger.onNext(())
        let movieList = try? output.movieBannerList.toBlocking(timeout: 1).first()
        let movieCategoryList = try? output.movieCategoryList.toBlocking(timeout: 1).first()
        
        // assert
        XCTAssert(useCase.getMovieListCalled)
        XCTAssertEqual(movieList?.count, 1)
        XCTAssertEqual(movieCategoryList?.count, 4)
    }
    
    func test_selectCategoryTriggerInvoked_toMovieCategoryList() {
        // act
        loadTrigger.onNext(())
        selectedCategoryTrigger.onNext(IndexPath(row: 0, section: 0))
        
        // assert
        XCTAssert(navigator.toMovieCategoryCalled)
    }
    
    func test_selectedBannerTriggerInvoked_toMovieDetail() {
        // act
        loadTrigger.onNext(())
        selectedBannerTrigger.onNext(IndexPath(row: 0, section: 0))
        
        // assert
        XCTAssert(navigator.toMovieDetailCalled)
    }
    
    func test_searchMovieTriggerInvoked_toSearchMovie() {
        // act
        searchMovieTrigger.onNext(())
        
        // assert
        XCTAssert(navigator.toSearchMovieCalled)
    }
    
    func test_selectedMovieTriggerInvoked_toMovieDetail() {
        // act
        loadTrigger.onNext(())
//        let movie = Movie().with {
//            $0.id = 111
//            $0.title = "MOVIE"
//        }
        selectedMovieTrigger.onNext(Movie())

        // assert
        XCTAssert(navigator.toMovieDetailCalled)
    }
}
