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
        let loadTrigger: Driver<CategoryType>
        let reloadTrigger: Driver<CategoryType>
        let loadMoreTrigger: Driver<CategoryType>
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
        
        let loadMoreOutput = setupLoadMorePagingWithParam(loadTrigger: input.loadTrigger,
                                                          getItems: useCase.getMovieList,
                                                          refreshTrigger: input.reloadTrigger,
                                                          refreshItems: useCase.getMovieList,
                                                          loadMoreTrigger: input.loadMoreTrigger,
                                                          loadMoreItems: useCase.loadMoreMovieList)
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let movieList = page
            .map { $0.items.map {$0} }
            .asDriverOnErrorJustComplete()
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movieList) {
                return ($0, $1)
            }
            .map { (indexPath, movies) in
                return movies[indexPath.row]
            }
            .do(onNext: { (movie) in
                // Todo
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
