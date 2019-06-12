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
    
    func searchMovie(key: String,
                     page: Int) -> Observable<PagingInfo<Movie>>
    
    func getMovieDetail(id: Int) -> Observable<Movie>
    
    func getMovieFavorites() -> Observable<[MovieFavorite]>
    func addMovieFavorite(_ movie: Movie) -> Observable<Void>
    func delete(_ movie: MovieFavorite) -> Observable<Void>
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
    
    func searchMovie(key: String,
                     page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.SearchMovieListInput(keySearch: key, page: page)
        return API.shared.searchMovieList(input)
            .map { output in
                guard let movies = output.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: movies)
            }
    }
    
    func getMovieDetail(id: Int) -> Observable<Movie> {
        let input = API.GetMovieDetailInput(id: id)
        return API.shared.getMovieDetail(input)
    }
    
    func getMovieFavorites() -> Observable<[MovieFavorite]> {
        return all()
    }
    
    func addMovieFavorite(_ movie: Movie) -> Observable<Void> {
        var movieFavorite = MovieFavorite().with {
            $0.id = String(movie.id)
            $0.title = movie.title
            $0.posterPath = movie.posterPath
        }
        return addOrUpdate(movieFavorite)
    }
    
    func delete(_ movie: MovieFavorite) -> Observable<Void> {
        return deleteItem(havingID: movie.id)
    }
}

extension MovieRepository: CoreDataRepository {
    static func map(from item: MovieFavorite, to entity: MovieFavoriteEntity) {
        entity.id = item.id
        entity.title = item.title
        entity.posterPath = item.posterPath
    }
    
    static func item(from entity: MovieFavoriteEntity) -> MovieFavorite? {
        guard let id = entity.id else { return nil }
        return MovieFavorite(id: id,
                             title: entity.title ?? "",
                             posterPath: entity.posterPath ?? ""
        )
    }
}
