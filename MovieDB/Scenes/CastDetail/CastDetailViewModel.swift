//
//  CastDetailViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct CastDetailViewModel {
    let useCase: CastDetailUseCaseType
    let navigator: CastDetailNavigatorType
    let cast: Cast
}

extension CastDetailViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let backScreenTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let castDetail: Driver<Cast>
        let movieList: Driver<[Movie]>
        let backScreen: Driver<Void>
        let selectedMovie: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let castDetail = input.loadTrigger
            .flatMapLatest { _ -> Driver<Cast> in
                self.useCase.getCastDetail(id: self.cast.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let movieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMovieListByCast(id: self.cast.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let backScreen = input.backScreenTrigger
            .do(onNext: {
                self.navigator.backScreen()
            })
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movieList) {
                return $1[$0.row]
            }
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        return Output(castDetail: castDetail,
                      movieList: movieList,
                      backScreen: backScreen,
                      selectedMovie: selectedMovie)
    }
}

