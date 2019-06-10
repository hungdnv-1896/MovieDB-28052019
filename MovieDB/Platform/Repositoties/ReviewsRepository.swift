//
//  ReviewsRepository.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol ReviewsRepositoryType {
    func getReviewList(id: Int,
                      page: Int) -> Observable<PagingInfo<Review>>
}

final class ReviewsRepository: ReviewsRepositoryType {
    func getReviewList(id: Int,
                      page: Int) -> Observable<PagingInfo<Review>> {
        let input = API.GetReviewListInput(id: id, page: page)
        return API.shared.getListReview(input)
            .map { output in
                guard let reviews = output.reviews else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Review>(page: page, items: reviews)
        }
    }
}

