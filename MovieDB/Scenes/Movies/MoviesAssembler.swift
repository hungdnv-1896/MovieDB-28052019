//
//  MoviesAssembler.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/27/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController
    func resolve(navigationController: UINavigationController) -> MoviesViewModel
    func resolve(navigationController: UINavigationController) -> MoviesNavigatorType
    func resolve() -> MoviesUseCaseType
}

extension MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController {
        let vc = MoviesViewController.instantiate()
        let movieTabbarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie"), tag: 0)
        vc.tabBarItem = movieTabbarItem
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        let vm: MoviesViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> MoviesViewModel {
        return MoviesViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension MoviesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesNavigatorType {
        return MoviesNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MoviesUseCaseType {
        return MoviesUseCase(movieRepository: resolve())
    }
}
