//
//  MovieDetailUseCase.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MovieDetailUseCaseType {
    func getMovieDetail(movieId: Int) -> Observable<Movie>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieDetailRepository: MovieDetailRepositoryType
    
    func getMovieDetail(movieId: Int) -> Observable<Movie> {
        return movieDetailRepository.getMovieDetail(id: movieId)
    }
}
