//
//  SearchMovieUseCase.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/4/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol SearchMovieUseCaseType {
    func searchMovie(_ key: String) -> Observable<PagingInfo<Movie>>
    func loadMoreSearchMovie(key: String, page: Int) -> Observable<PagingInfo<Movie>>
}

struct SearchMovieUseCase: SearchMovieUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func searchMovie(_ key: String) -> Observable<PagingInfo<Movie>> {
        return loadMoreSearchMovie(key: key, page: 1)
    }
    
    func loadMoreSearchMovie(key: String, page: Int) -> Observable<PagingInfo<Movie>> {
        return movieRepository.searchMovie(key: key, page: page)
    }
}
