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
    }
    
    struct Output {
        let movieCategoryList: Driver<[CategotyType]>
        let movieBannerList: Driver<[Movie]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let popularMovieList = useCase.getMovieList(.popular([]))
            .map { $0.items.map { $0 } }
            .startWith([])
            .asDriverOnErrorJustComplete()
        
        let nowPlayingMovieList = useCase.getMovieList(.nowPlaying([]))
            .map { $0.items.map { $0 } }
            .startWith([])
            .asDriverOnErrorJustComplete()
        
        let upcomingMovieList = useCase.getMovieList(.upcoming([]))
            .map { $0.items.map { $0 } }
            .startWith([])
            .asDriverOnErrorJustComplete()
        
        let topRateMovieList = useCase.getMovieList(.topRate([]))
            .map { $0.items.map { $0 } }
            .startWith([])
            .asDriverOnErrorJustComplete()
        
        let movieBannerList = popularMovieList.asObservable()
            .take(4)
            .asDriverOnErrorJustComplete()
        
        let movieCategoryList = Driver
            .combineLatest(popularMovieList, nowPlayingMovieList, upcomingMovieList, topRateMovieList)
            .map { params -> [CategotyType] in
                let categoryList: [CategotyType] = [.popular(params.0), .nowPlaying(params.1), .upcoming(params.2), .topRate(params.3)]
                return categoryList
            }
        
        return Output(
            movieCategoryList: movieCategoryList,
            movieBannerList: movieBannerList
        )
    }
}
