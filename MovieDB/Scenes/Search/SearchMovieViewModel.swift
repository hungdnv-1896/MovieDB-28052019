//
//  SearchMovieViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/4/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct SearchMovieViewModel {
    let useCase: SearchMovieUseCaseType
    let navigator: SearchMovieNavigatorType
}

extension SearchMovieViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<String>
        let reloadTrigger: Driver<String>
        let loadMoreTrigger: Driver<String>
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
                                                          getItems: useCase.searchMovie,
                                                          refreshTrigger: input.reloadTrigger,
                                                          refreshItems: useCase.searchMovie,
                                                          loadMoreTrigger: input.loadMoreTrigger,
                                                          loadMoreItems: useCase.loadMoreSearchMovie)

        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput

        let movieList = page
            .map { $0.items.map {$0} }
            .asDriverOnErrorJustComplete()

        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movieList) {
                return $1[$0.row]
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

