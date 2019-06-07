//
//  CastDetailAssembler.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol CastDetailAssembler {
    func resolve(navigationController: UINavigationController,
                 cast: Cast) -> CastDetailViewController
    func resolve(navigationController: UINavigationController,
                 cast: Cast) -> CastDetailViewModel
    func resolve(navigationController: UINavigationController) -> CastDetailNavigatorType
    func resolve() -> CastDetailUseCaseType
}

extension CastDetailAssembler {
    func resolve(navigationController: UINavigationController,
                 cast: Cast) -> CastDetailViewController {
        let castDetailVC = CastDetailViewController.instantiate()
        let vm: CastDetailViewModel = resolve(navigationController: navigationController,
                                               cast: cast)
        castDetailVC.bindViewModel(to: vm)
        return castDetailVC
    }
    
    func resolve(navigationController: UINavigationController,
                 cast: Cast) -> CastDetailViewModel {
        return CastDetailViewModel(useCase: resolve(),
                                    navigator: resolve(navigationController: navigationController),
                                    cast: cast)
    }
}

extension CastDetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CastDetailNavigatorType {
        return CastDetailNavigator(assembler: self,
                                    navigationController: navigationController)
    }
    
    func resolve() -> CastDetailUseCaseType {
        return CastDetailUseCase(castDetailRepository: resolve())
    }
}
