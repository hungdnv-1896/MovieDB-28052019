//
//  ReviewModel.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct ReviewViewModel {
    let review: Review
    
    var id: String {
        return review.id
    }
    
    var author: String {
        return review.author
    }
    
    var content: String {
        return review.content
    }
}
