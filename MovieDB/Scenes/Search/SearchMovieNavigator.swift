//
//  SearchMovieNavigator.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/4/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol SearchMovieNavigatorType {
    func toMovieDetail(movie: Movie)
}

struct SearchMovieNavigator: SearchMovieNavigatorType {
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail(movie: Movie) {
        let vc: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                              movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}
