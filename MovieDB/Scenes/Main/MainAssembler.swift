//
//  MainAssembler.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/27/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MainAssembler {
    func resolve() -> MainViewController
}

extension MainAssembler {
}

extension AppAssembler where Self: DefaultAssembler {
    func resolve() -> MainViewController {
        let moviesNavigationController = UINavigationController()
        let moviesVC: MoviesViewController = resolve(navigationController: moviesNavigationController)
        let movieTabbarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie"), tag: 0)
        moviesVC.tabBarItem = movieTabbarItem
        moviesNavigationController.viewControllers.append(moviesVC)
        
        let favoriteNavigationController = UINavigationController()
        let favoriteVC: FavoriteViewController = resolve(navigationController: favoriteNavigationController)
        let favoriteTabbarItem2 = UITabBarItem(title: "Favorite", image: UIImage(named: "favorite"), tag: 1)
        favoriteVC.tabBarItem = favoriteTabbarItem2
        favoriteNavigationController.viewControllers.append(favoriteVC)
        
        let mainVC = MainViewController()
        mainVC.viewControllers = [moviesNavigationController, favoriteNavigationController]
        
        return mainVC
    }
}
