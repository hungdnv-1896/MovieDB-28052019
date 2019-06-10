//
//  ReviewsMovieUseCase.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol ReviewsMovieUseCaseType {
    func getReviewList(_ id: Int) -> Observable<PagingInfo<Review>>
    func loadMoreReviewList(id: Int, page: Int) -> Observable<PagingInfo<Review>>
}

struct ReviewsMovieUseCase: ReviewsMovieUseCaseType {
    let reviewRepository: ReviewsRepositoryType
    
    func getReviewList(_ id: Int) -> Observable<PagingInfo<Review>> {
        return loadMoreReviewList(id: id, page: 1)
    }
    
    func loadMoreReviewList(id: Int, page: Int) -> Observable<PagingInfo<Review>> {
        return reviewRepository.getReviewList(id: id, page: page)
    }
}
