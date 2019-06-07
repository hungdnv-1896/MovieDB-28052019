//
//  MovieDetailRepository.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MovieDetailRepositoryType {
    func getMovieDetail(id: Int) -> Observable<Movie>
}

final class MovieDetailRepository: MovieDetailRepositoryType {
    
    func getMovieDetail(id: Int) -> Observable<Movie> {
        let input = API.GetMovieDetailInput(id: id)
        return API.shared.getMovieDetail(input)
    }
}
