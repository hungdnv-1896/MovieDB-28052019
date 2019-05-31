//
//  MoviesUseCase.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/27/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MoviesUseCaseType {
    func getMovieList(_ category: CategoryType) -> Observable<PagingInfo<Movie>>
}

struct MoviesUseCase: MoviesUseCaseType {
    let movieRepository: MovieRepositoryType

    func getMovieList(_ category: CategoryType) -> Observable<PagingInfo<Movie>> {
        return movieRepository.getMovieList(category: category, page: 1)
    }
}
