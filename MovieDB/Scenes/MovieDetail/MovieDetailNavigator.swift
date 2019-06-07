//
//  MovieDetailNavigator.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol MovieDetailNavigatorType {
    func toCastDetail()
    func backScreen()
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toCastDetail() {
        
    }
    
    func backScreen() {
        navigationController.popViewController(animated: true)
    }
}
