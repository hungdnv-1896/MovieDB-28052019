//
//  RepositoriesAssembler.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/30/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol RepositoriesAssembler {
    func resolve() -> MovieRepositoryType
    func resolve() -> MovieDetailRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> MovieRepositoryType {
        return MovieRepository()
    }
    
    func resolve() -> MovieDetailRepositoryType {
        return MovieDetailRepository()
    }
}
