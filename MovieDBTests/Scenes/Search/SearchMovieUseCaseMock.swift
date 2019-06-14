//
//  SearchMovieUseCaseMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import RxSwift
@testable import MovieDB

final class SearchMovieUseCaseMock: SearchMovieUseCaseType {
    
    //MARK: searchMovie
    var searchMoiveCalled = false
    
    var searchMovieReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 1 }
        ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func searchMovie(_ key: String) -> Observable<PagingInfo<Movie>> {
        searchMoiveCalled = true
        return searchMovieReturnValue
    }
    
    //MARK: loadMoreSearchMovie
    var loadMoreSearchMoviewCalled = false
    
    var loadMoreSearchMovieReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 2 }
        ]
        let page = PagingInfo<Movie>(page: 2, items: items)
        return Observable.just(page)
    }()
    
    
    func loadMoreSearchMovie(key: String, page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreSearchMoviewCalled = true
        return loadMoreSearchMovieReturnValue
    }
}
