//
//  FavoriteUseCaseMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import RxSwift

final class FavoriteUseCaseMock: FavoriteUseCaseType {
    
    //MARK: getMovieFavorite
    var getMovieFavoriteListCalled = false
    
    var getMovieFavoriteListReturnValue: Observable<PagingInfo<MovieFavorite>> = {
        let items = [MovieFavorite().with {$0.id = "1"}]
        let page = PagingInfo<MovieFavorite>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getMovieFavoriteList() -> Observable<PagingInfo<MovieFavorite>> {
        getMovieFavoriteListCalled = true
        return getMovieFavoriteListReturnValue
    }
    
    //MARK: loadMoreMovieFavoriteLsit
    var loadMoreMovieFavoriteListCalled = false
    
    var loadMoreMovieFavoriteListReturnValue: Observable<PagingInfo<MovieFavorite>> = {
        let items = [MovieFavorite().with {$0.id = "2"}]
        let page = PagingInfo<MovieFavorite>(page: 2, items: items)
        return Observable.just(page)
    }()
    
    func loadMoreMovieFavoriteList(page: Int) -> Observable<PagingInfo<MovieFavorite>> {
        loadMoreMovieFavoriteListCalled = true
        return loadMoreMovieFavoriteListReturnValue
    }
    
    //MARK: Delete
    var deleteCalled = false
    
    func delete(_ movie: MovieFavorite) -> Observable<Void> {
        deleteCalled = true
        return Observable.just(())
    }
}
