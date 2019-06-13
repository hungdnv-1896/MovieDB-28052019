//
//  CategoryUseCaseMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import RxSwift

final class CategoryUseCaseMock: CategoryUseCaseType {
    
    //MARK: getMovieList
    var getMovieListCalled = false
    
    var getMovieListReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 1 }
        ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getMovieList(_ category: CategoryType) -> Observable<PagingInfo<Movie>> {
        getMovieListCalled = true
        return getMovieListReturnValue
    }
    
    //MARK: loadMoreMovieList
    var loadMoreMoveListCalled = false
    
    var loadMoreMovieListReturnValue: Observable<PagingInfo<Movie>> = {
        let movies = [
            Movie().with{ $0.id = 2 }
        ]
        let page = PagingInfo<Movie>(page: 2, items: movies)
        return Observable.just(page)
    }()
    
    
    func loadMoreMovieList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreMoveListCalled = true
        return loadMoreMovieListReturnValue
    }
    
}
