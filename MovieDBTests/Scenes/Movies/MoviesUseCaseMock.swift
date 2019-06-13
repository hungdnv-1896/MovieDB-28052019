//
//  MoviesUseCaseMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import RxSwift

final class MoviesUseCaseMock: MoviesUseCaseType {
    
    // MARK: getMovieList
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
}
