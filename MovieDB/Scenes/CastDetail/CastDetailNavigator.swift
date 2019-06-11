//
//  CastDetailNavigator.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol CastDetailNavigatorType {
    func backScreen()
    func toMovieDetail(movie: Movie)
}

struct CastDetailNavigator: CastDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func backScreen() {
        navigationController.popViewController(animated: true)
    }
    
    func toMovieDetail(movie: Movie) {
        let vc: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                              movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}

