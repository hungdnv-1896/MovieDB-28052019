//
//  MovieRepository.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

protocol MovieRepositoryType {
    func getMovieList(category: CategoryType,
                      page: Int) -> Observable<PagingInfo<Movie>>
}

final class MovieRepository: MovieRepositoryType {
    func getMovieList(category: CategoryType,
                     page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.GetMovieListInput(category: category, page: page)
        return API.shared.getMovieList(input)
            .map { output in
                guard let movies = output.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: movies)
        }
    }
}
