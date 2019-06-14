//
//  ReviewsUseCaseMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import RxSwift

final class ReviewsUseCaseMock: ReviewsMovieUseCaseType {
    
    //MARK: getReviewList
    var getReviewListCalled = false
    
    var getReviewListReturnValue: Observable<PagingInfo<Review>> = {
        let items = [Review().with {$0.id = "1"}]
        let page = PagingInfo<Review>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getReviewList(_ id: Int) -> Observable<PagingInfo<Review>> {
        getReviewListCalled = true
        return getReviewListReturnValue
    }
    
    //MARK: loadMoreReviewList
    var loadMoreReviewListCalled = false
    
    var loadMoreReviewListReturnValue: Observable<PagingInfo<Review>> = {
        let items = [Review().with {$0.id = "2"}]
        let page = PagingInfo<Review>(page: 2, items: items)
        return Observable.just(page)
    }()
    func loadMoreReviewList(id: Int, page: Int) -> Observable<PagingInfo<Review>> {
        loadMoreReviewListCalled = true
        return loadMoreReviewListReturnValue
    }
    
    
}
