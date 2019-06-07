//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct MovieDetailViewModel {
    let useCase: MovieDetailUseCaseType
    let navigator: MovieDetailNavigatorType
    let movie: Movie
}

extension MovieDetailViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let showCastDetailTrigger: Driver<IndexPath>
        let backScreenTrigger: Driver<Void>
    }
    
    struct Output {
        let movieDetail: Driver<Movie>
        let castList: Driver<[Cast]>
        let backScreen: Driver<Void>
        let showCastDetail: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()

        let movieDetail = input.loadTrigger
            .flatMapLatest { _ -> Driver<Movie> in
                self.useCase.getMovieDetail(movieId: self.movie.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let castList = movieDetail
            .map { $0.castList }
        
        let backScreen = input.backScreenTrigger
            .do(onNext: {
                self.navigator.backScreen()
            })
        
        let showCastDetail = input.showCastDetailTrigger
            .withLatestFrom(castList) {
            return $1[$0.row]
            }
            .do(onNext: { (cast) in
                self.navigator.toCastDetail(cast: cast)
            })
            .mapToVoid()
        
        
        return Output(movieDetail: movieDetail,
                      castList: castList,
                      backScreen: backScreen,
                      showCastDetail: showCastDetail)
    }
}
