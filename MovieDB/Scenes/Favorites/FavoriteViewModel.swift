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
        let loadMoreTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
        let deleteFavoriteTrigger: Driver<MovieFavorite>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let movieFavoriteList: Driver<[MovieFavorite]>
        let selectedMovie: Driver<Void>
        let isEmptyData: Driver<Bool>
        let deleteFavorite: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let loadMoreOutput = setupLoadMorePaging(
            loadTrigger: input.loadTrigger,
            getItems: useCase.getMovieFavoriteList,
            refreshTrigger: input.reloadTrigger,
            refreshItems: useCase.getMovieFavoriteList,
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: useCase.loadMoreMovieFavoriteList)
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let movieFavoriteList = page
            .map { $0.items.map { $0 } }
            .asDriverOnErrorJustComplete()
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movieFavoriteList) {
                return ($0, $1)
            }
            .map { indexPath, movieFavoriteList in
                return movieFavoriteList[indexPath.row]
            }
            .do(onNext: { movieFavorite in
                var movie = Movie()
                movie.id = Int(movieFavorite.id) ?? 0
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: movieFavoriteList)
        
        let deleteFavorite = input.deleteFavoriteTrigger
            .flatMap { movie -> Driver<MovieFavorite> in
                return self.useCase.delete(movie)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .map { _ in movie }
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: { movie in
                var favoriteList = page.value.items
                favoriteList.removeAll { $0.id == movie.id }
                let updatedPage = PagingInfo(page: page.value.page, items: favoriteList)
                page.accept(updatedPage)
            })
            .mapToVoid()
        
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            movieFavoriteList: movieFavoriteList,
            selectedMovie: selectedMovie,
            isEmptyData: isEmptyData,
            deleteFavorite: deleteFavorite
        )
    }
}
