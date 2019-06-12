//
//  MovieDetailUseCase.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MovieDetailUseCaseType {
    func getMovieDetail(movieId: Int) -> Observable<Movie>
    func addMovieFavorite(_ movie: Movie) -> Observable<Void>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func getMovieDetail(movieId: Int) -> Observable<Movie> {
        return movieRepository.getMovieDetail(id: movieId)
    }
    
    func addMovieFavorite(_ movie: Movie) -> Observable<Void> {
        return movieRepository.addMovieFavorite(movie)
    }
}
