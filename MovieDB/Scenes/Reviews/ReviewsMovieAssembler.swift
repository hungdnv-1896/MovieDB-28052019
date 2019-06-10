//
//  ReviewsMovieAssembler.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol ReviewsMovieAssembler {
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> ReviewsMovieViewController
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> ReviewsMovieViewModel
    func resolve(navigationController: UINavigationController) -> ReviewsMovieNavigatorType
    func resolve() -> ReviewsMovieUseCaseType
}

extension ReviewsMovieAssembler {
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> ReviewsMovieViewController {
        let reviewsVC = ReviewsMovieViewController.instantiate()
        let vm: ReviewsMovieViewModel = resolve(navigationController: navigationController,
                                                movie: movie)
        reviewsVC.bindViewModel(to: vm)
        return reviewsVC
    }
    
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> ReviewsMovieViewModel {
        return ReviewsMovieViewModel(useCase: resolve(),
                                     navigator: resolve(navigationController: navigationController),
                                     movie: movie)
    }
}

extension ReviewsMovieAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ReviewsMovieNavigatorType {
        return ReviewsMovieNavigator(assembler: self,
                                     navigationController: navigationController)
    }
    
    func resolve() -> ReviewsMovieUseCaseType {
        return ReviewsMovieUseCase(reviewRepository: resolve())
    }
}

