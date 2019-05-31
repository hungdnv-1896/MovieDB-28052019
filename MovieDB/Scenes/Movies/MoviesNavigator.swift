//
//  MoviesNavigator.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/27/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MoviesNavigatorType {
    func toMovieCategory()
    func toSearchMovie()
    func toMovieDetail()
}

struct MoviesNavigator: MoviesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieCategory() {
        
    }
    
    func toSearchMovie() {
        
    }
    
    func toMovieDetail() {
        
    }
}
