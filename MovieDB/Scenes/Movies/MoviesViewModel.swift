//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/27/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct MoviesViewModel {
    let navigator: MoviesNavigatorType
    let useCase: MoviesUseCaseType
}

extension MoviesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectedCategoryTrigger: Driver<IndexPath>
        let searchMovieTrigger: Driver<Void>
        let selectedBannerTrigger: Driver<IndexPath>
        let selectedMovieTrigger: Driver<Movie>
    }
    
    struct Output {
        let movieCategoryList: Driver<[CategoryType]>
        let movieBannerList: Driver<[Movie]>
        let selectedCategory: Driver<Void>
        let searchMovie: Driver<Void>
        let selectedBanner: Driver<Void>
        let selectedMovie: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let popularMovieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMovieList(.popular([]))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let nowPlayingMovieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMovieList(.nowPlaying([]))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let upcomingMovieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMovieList(.upcoming([]))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let topRateMovieList = input.loadTrigger
            .flatMapLatest { _ -> Driver<PagingInfo<Movie>> in
                self.useCase.getMovieList(.topRate([]))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { $0.items }
            .startWith([])
        
        let movieBannerList = popularMovieList.asObservable()
            .flatMap({ (movies) -> Observable<[Movie]> in
                return Observable.just(Array(movies.prefix(4)))
            })
            .asDriverOnErrorJustComplete()
        
        let movieCategoryList = Driver
            .combineLatest(popularMovieList, nowPlayingMovieList, upcomingMovieList, topRateMovieList)
            .map { params -> [CategoryType] in
                let categoryList: [CategoryType] = [.popular(params.0),
                                                    .nowPlaying(params.1),
                                                    .upcoming(params.2),
                                                    .topRate(params.3)]
                return categoryList
            }
        
        let selectedCategory = input.selectedCategoryTrigger
            .withLatestFrom(movieCategoryList) {
                return ($0, $1)
            }
            .map { (indexPath, movieCategories) in
                return movieCategories[indexPath.row]
            }
            .do(onNext: { (category) in
                self.navigator.toMovieCategory(category: category)
            })
            .mapToVoid()
        
        let selectedBanner = input.selectedBannerTrigger
            .withLatestFrom(movieBannerList) {
                return ($0, $1)
            }
            .map { (indexPath, movieBanners) in
                return movieBanners[indexPath.row]
            }
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        let selectedMovie = input.selectedMovieTrigger
            .asDriver()
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        let searchMovie = input.searchMovieTrigger
            .do(onNext: { (category) in
                self.navigator.toSearchMovie()
            })
            .mapToVoid()
        
        return Output(
            movieCategoryList: movieCategoryList,
            movieBannerList: movieBannerList,
            selectedCategory: selectedCategory,
            searchMovie: searchMovie,
            selectedBanner: selectedBanner,
            selectedMovie: selectedMovie
        )
    }
}
