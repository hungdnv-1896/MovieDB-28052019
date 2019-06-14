//
//  MovieDetailUseCaseMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import RxSwift

final class MovieDetailUseCaseMock: MovieDetailUseCaseType {
    
    //MARK: getMovieDetail
    var getMovieDetailCalled = false
    
    var getMovieDetailReturnValue: Observable<Movie> = {
        let item = Movie().with {
            $0.id = 1
            $0.castList = [Cast()]
        }
        return Observable.just(item)
    }()
    
    func getMovieDetail(movieId: Int) -> Observable<Movie> {
        getMovieDetailCalled = true
        return getMovieDetailReturnValue
    }
    
    //MARK: addMovieDetail
    var addMovieFavoriteCalled = false
    
    func addMovieFavorite(_ movie: Movie) -> Observable<Void> {
        addMovieFavoriteCalled = true
        return Observable.just(())
    }
}
