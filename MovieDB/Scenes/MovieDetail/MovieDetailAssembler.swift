//
//  MovieDetailAssembler.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MovieDetailAssemler {
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> MovieDetailViewController
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> MovieDetailViewModel
    func resolve(navigationController: UINavigationController) -> MovieDetailNavigatorType
    func resolve() -> MovieDetailUseCaseType
}

extension MovieDetailAssemler {
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> MovieDetailViewController {
        let categoryVC = MovieDetailViewController.instantiate()
        let vm: MovieDetailViewModel = resolve(navigationController: navigationController,
                                               movie: movie)
        categoryVC.bindViewModel(to: vm)
        return categoryVC
    }
    
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> MovieDetailViewModel {
        return MovieDetailViewModel(useCase: resolve(),
                                    navigator: resolve(navigationController: navigationController),
                                    movie: movie)
    }
}

extension MovieDetailAssemler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MovieDetailNavigatorType {
        return MovieDetailNavigator(assembler: self,
                                    navigationController: navigationController)
    }
    
    func resolve() -> MovieDetailUseCaseType {
        return MovieDetailUseCase(movieDetailRepository: resolve())
    }
}
