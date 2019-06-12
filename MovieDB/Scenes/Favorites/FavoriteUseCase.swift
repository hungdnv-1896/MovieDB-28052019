//
//  FavoriteUseCase.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/28/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol FavoriteUseCaseType {
    func getMovieFavoriteList() -> Observable<PagingInfo<MovieFavorite>>
    func loadMoreMovieFavoriteList(page: Int) -> Observable<PagingInfo<MovieFavorite>>
    func delete(_ movie: MovieFavorite) -> Observable<Void>
}

struct FavoriteUseCase: FavoriteUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func getMovieFavoriteList() -> Observable<PagingInfo<MovieFavorite>> {
        return movieRepository
            .getMovieFavorites()
            .map { PagingInfo(page: 1, items: $0) }
    }
    
    func loadMoreMovieFavoriteList(page: Int) -> Observable<PagingInfo<MovieFavorite>> {
        return Observable.empty()
    }
    
    func delete(_ movie: MovieFavorite) -> Observable<Void> {
        return movieRepository.delete(movie)
    }
}
