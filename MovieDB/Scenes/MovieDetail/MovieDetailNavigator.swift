//
//  MovieDetailNavigator.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MovieDetailNavigatorType {
    func toCastDetail(cast: Cast)
    func backScreen()
    func toReviews(movie: Movie)
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toCastDetail(cast: Cast) {
        let vc: CastDetailViewController = assembler.resolve(navigationController: navigationController,
                                                             cast: cast)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func backScreen() {
        navigationController.popViewController(animated: true)
    }
    
    func toReviews(movie: Movie) {
        let vc: ReviewsMovieViewController = assembler.resolve(navigationController: navigationController,
                                                               movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}
