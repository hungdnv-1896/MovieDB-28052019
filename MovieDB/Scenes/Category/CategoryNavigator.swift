//
//  CategoryNavigator.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/1/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol CategoryNavigatorType {
    func toMovieDetail()
}

struct CategoryNavigator: CategoryNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail() {
        
    }
}
