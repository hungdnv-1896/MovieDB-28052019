//
//  CastDetailUseCaseMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB

final class CastDetailUseCaseMock: CastDetailUseCaseType {
    
    //MARK: getCastDetail
    var getCastDetailCalled = false
    
    var getCastDetailReturnValue: Observable<Cast> = {
        let item = Cast().with {
            $0.id = 1
        }
        return Observable.just(item)
    }()
    
    func getCastDetail(id: Int) -> Observable<Cast> {
        getCastDetailCalled = true
        return getCastDetailReturnValue
    }
    
    //MARK: getMovieListByCast
    var getMovieListByCastCalled = false
    
    var getMovieListByCastReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 1 }
        ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getMovieListByCast(id: Int) -> Observable<PagingInfo<Movie>> {
        getMovieListByCastCalled = true
        return getMovieListByCastReturnValue
    }
    
    //MARK: loadMoreMovieListByCast
    var loadMoreMovieListByCastCalled = false
    
    var loadMoreMovieListByCastReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie().with { $0.id = 2 }
        ]
        let page = PagingInfo<Movie>(page: 2, items: items)
        return Observable.just(page)
    }()
    
    func loadMoreMovieListByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreMovieListByCastCalled = true
        return loadMoreMovieListByCastReturnValue
    }
}
