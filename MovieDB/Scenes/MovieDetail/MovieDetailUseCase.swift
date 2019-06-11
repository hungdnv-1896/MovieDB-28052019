//
//  MovieDetailUseCase.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import Realm
import RealmSwift

protocol MovieDetailUseCaseType {
    func getMovieDetail(movieId: Int) -> Observable<Movie>
    func addMovieToFavorite(movie: Movie)
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieDetailRepository: MovieDetailRepositoryType
    
    func getMovieDetail(movieId: Int) -> Observable<Movie> {
        return movieDetailRepository.getMovieDetail(id: movieId)
    }
    
    func addMovieToFavorite(movie: Movie) {
        let movieEntity = movie.toEntity()
        let realm = try! Realm()
        try! realm.write {
            realm.add(movieEntity, update: true)
        }
    }
}
