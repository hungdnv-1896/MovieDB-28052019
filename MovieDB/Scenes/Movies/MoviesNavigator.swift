//
//  MoviesNavigator.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/27/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MoviesNavigatorType {
    func toMovieCategory(category: CategoryType)
    func toSearchMovie()
    func toMovieDetail(movie: Movie)
}

struct MoviesNavigator: MoviesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieCategory(category: CategoryType) {
        let vc: CategoryViewController = assembler.resolve(navigationController: navigationController,
                                                           category: category)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toSearchMovie() {
        let vc: SearchMovieViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toMovieDetail(movie: Movie) {
        let vc: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                              movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}
