//
//  FavoriteAssembler.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/28/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol FavoriteAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteViewController
    func resolve(navigationController: UINavigationController) -> FavoriteViewModel
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType
    func resolve() -> FavoriteUseCaseType
}

extension FavoriteAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteViewController {
        let vc = FavoriteViewController.instantiate()
//        let vm: MoviesViewModel = resolve(navigationController: navigationController)
//        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> FavoriteViewModel {
        return FavoriteViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension FavoriteAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType {
        return FavoriteNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> FavoriteUseCaseType {
        return FavoriteUseCase()
    }
}
