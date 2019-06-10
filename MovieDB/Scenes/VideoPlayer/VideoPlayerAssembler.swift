//
//  VideoPlayerAssembler.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/9/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol VideoPlayerAssembler {
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> VideoPlayerViewController
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> VideoPlayerViewModel
    func resolve(navigationController: UINavigationController) -> VideoPlayerNavigatorType
    func resolve() -> VideoPlayerUseCaseType
}

extension VideoPlayerAssembler {
    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> VideoPlayerViewController {
        let reviewsVC = VideoPlayerViewController.instantiate()
        let vm: VideoPlayerViewModel = resolve(navigationController: navigationController,
                                               movie: movie)
        reviewsVC.bindViewModel(to: vm)
        return reviewsVC
    }
    

    func resolve(navigationController: UINavigationController,
                 movie: Movie) -> VideoPlayerViewModel {
        return VideoPlayerViewModel(useCase: resolve(),
                                    navigator: resolve(navigationController: navigationController),
                                    movie: movie)
    }
}

extension VideoPlayerAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> VideoPlayerNavigatorType {
        return VideoPlayerNavigator(assembler: self,
                                    navigationController: navigationController)
    }
    
    func resolve() -> VideoPlayerUseCaseType {
        return VideoPlayerUseCase(videoRepository: resolve())
    }
}

