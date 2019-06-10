//
//  ReviewsMovieViewModel.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct ReviewsMovieViewModel {
    let useCase: ReviewsMovieUseCaseType
    let navigator: ReviewsMovieNavigatorType
    let movie: Movie
}

extension ReviewsMovieViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let reviewList: Driver<[Review]>
        let isEmptyData: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        
        let loadMoreOutput = setupLoadMorePaging(
            loadTrigger: input.loadTrigger,
            getItems: {
                self.useCase.getReviewList(self.movie.id)
            },
            refreshTrigger: input.reloadTrigger,
            refreshItems: {
                self.useCase.getReviewList(self.movie.id)
            },
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: { page in
                self.useCase.loadMoreReviewList(id: self.movie.id, page: page)
            }
        )
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let reviewList = page
            .map { $0.items.map {$0} }
            .asDriverOnErrorJustComplete()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: reviewList)
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            reviewList: reviewList,
            isEmptyData: isEmptyData
        )
    }
}

