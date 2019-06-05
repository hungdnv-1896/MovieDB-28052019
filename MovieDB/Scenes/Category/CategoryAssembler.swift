//
//  CategoryAssembler.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/1/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol CategoryAssemler {
    func resolve(navigationController: UINavigationController,
                 category: CategoryType) -> CategoryViewController
    func resolve(navigationController: UINavigationController,
                 category: CategoryType) -> CategoryViewModel
    func resolve(navigationController: UINavigationController) -> CategoryNavigatorType
    func resolve() -> CategoryUseCaseType
}

extension CategoryAssemler {
    func resolve(navigationController: UINavigationController,
                 category: CategoryType) -> CategoryViewController {
        let categoryVC = CategoryViewController.instantiate()
        let vm: CategoryViewModel = resolve(navigationController: navigationController,
                                            category: category)
        categoryVC.bindViewModel(to: vm)
        return categoryVC
    }
    
    func resolve(navigationController: UINavigationController,
                 category: CategoryType) -> CategoryViewModel {
        return CategoryViewModel(useCase: resolve(),
                                 navigator: resolve(navigationController: navigationController),
                                 category: category)
    }
}

extension CategoryAssemler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CategoryNavigatorType {
        return CategoryNavigator(assembler: self,
                                 navigationController: navigationController)
    }
    
    func resolve() -> CategoryUseCaseType {
        return CategoryUseCase(movieRepository: resolve())
    }
}
