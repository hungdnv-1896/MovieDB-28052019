//
//  CategoryViewModel.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/1/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct CategoryViewModel {
    let useCase: CategoryUseCaseType
    let navigator: CategoryNavigatorType
    let category: CategoryType
}

extension CategoryViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let movieList: Driver<[Movie]>
        let selectedMovie: Driver<Void>
        let isEmptyData: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let loadTrigger = input.loadTrigger
            .map { _ in self.category }
        let reloadTrigger = input.reloadTrigger
            .withLatestFrom(loadTrigger)
        let loadMoreTrigger = input.loadMoreTrigger
            .withLatestFrom(loadTrigger)
        
        let loadMoreOutput = setupLoadMorePagingWithParam(loadTrigger: loadTrigger,
                                                          getItems: useCase.getMovieList,
                                                          refreshTrigger: reloadTrigger,
                                                          refreshItems: useCase.getMovieList,
                                                          loadMoreTrigger: loadMoreTrigger,
                                                          loadMoreItems: useCase.loadMoreMovieList)
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let movieList = page
            .map { $0.items.map {$0} }
            .asDriverOnErrorJustComplete()
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movieList) {
                return $1[$0.row]
            }
            .do(onNext: { (movie) in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: movieList)
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            movieList: movieList,
            selectedMovie: selectedMovie,
            isEmptyData: isEmptyData)
    }
}
