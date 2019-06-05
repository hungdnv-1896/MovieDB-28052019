//
//  SearchMovieNavigator.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/4/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol SearchMovieNavigatorType {
    func toMovieDetail()
}

struct SearchMovieNavigator: SearchMovieNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail() {
        
    }
}
