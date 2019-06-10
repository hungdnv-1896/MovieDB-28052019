//
//  ReviewsMovieNavigator.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol ReviewsMovieNavigatorType {}

struct ReviewsMovieNavigator: ReviewsMovieNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
