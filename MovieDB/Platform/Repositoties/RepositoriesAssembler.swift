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
    func resolve() -> CastDetailRepositoryType
    func resolve() -> ReviewsRepositoryType
    func resolve() -> VideoRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> MovieRepositoryType {
        return MovieRepository()
    }
    
    func resolve() -> MovieDetailRepositoryType {
        return MovieDetailRepository()
    }
    
    func resolve() -> CastDetailRepositoryType {
        return CastDetailRepository()
    }
    
    func resolve() -> ReviewsRepositoryType {
        return ReviewsRepository()
    }
    
    func resolve() -> VideoRepositoryType {
        return VideoRepository()
    }
}
