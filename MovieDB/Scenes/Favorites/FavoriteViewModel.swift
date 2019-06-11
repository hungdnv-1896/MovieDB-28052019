//
//  FavoriteViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/28/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct FavoriteViewModel {
    let navigator: FavoriteNavigatorType
    let useCase: FavoriteUseCaseType
}

extension FavoriteViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
        let deleteFavoriteTrigger: Driver<Movie>
    }
    
    struct Output {
        let listMovie: Driver<[Movie]>
        let selectMovie: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let deleteFavorite = input.deleteFavoriteTrigger
            .do(onNext: { (movie) in
                self.useCase.deleteMovie(id: movie.id)
            })
            .mapToVoid()

        let listMovie = Driver.merge(input.loadTrigger, input.reloadTrigger, deleteFavorite)
            .flatMap { _ -> Driver<[Movie]> in
                var movies = [Movie]()
                let movieEntities = self.useCase.getListFavorite()
                for entity in movieEntities {
                    let movie = entity.toModel()
                    movies.append(movie)
                }
                return Driver.just(movies)
        }
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(listMovie) {
                return $1[$0.row]
            }
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()

        return Output(listMovie: listMovie,
                      selectMovie: selectedMovie)
    }
}
