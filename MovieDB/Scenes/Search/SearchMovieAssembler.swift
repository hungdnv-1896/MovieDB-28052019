//
//  SearchMovieAssembler.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/4/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol SearchMovieAssemler {
    func resolve(navigationController: UINavigationController) -> SearchMovieViewController
    func resolve(navigationController: UINavigationController) -> SearchMovieViewModel
    func resolve(navigationController: UINavigationController) -> SearchMovieNavigatorType
    func resolve() -> SearchMovieUseCaseType
}

extension SearchMovieAssemler {
    func resolve(navigationController: UINavigationController) -> SearchMovieViewController {
        let categoryVC = SearchMovieViewController.instantiate()
        let vm: SearchMovieViewModel = resolve(navigationController: navigationController)
        categoryVC.bindViewModel(to: vm)
        return categoryVC
    }
    
    func resolve(navigationController: UINavigationController) -> SearchMovieViewModel {
        return SearchMovieViewModel(useCase: resolve(),
                                    navigator: resolve(navigationController: navigationController))
    }
}

extension SearchMovieAssemler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SearchMovieNavigatorType {
        return SearchMovieNavigator(assembler: self,
                                    navigationController: navigationController)
    }
    
    func resolve() -> SearchMovieUseCaseType {
        return SearchMovieUseCase(movieRepository: resolve())
    }
}

