//
//  CategoryUsecase.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/1/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol CategoryUseCaseType {
    func getMovieList(_ category: CategoryType) -> Observable<PagingInfo<Movie>>
    func loadMoreMovieList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>>
}

struct CategoryUseCase: CategoryUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func getMovieList(_ category: CategoryType) -> Observable<PagingInfo<Movie>> {
        return loadMoreMovieList(category: category, page: 1)
    }
    
    func loadMoreMovieList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        return movieRepository.getMovieList(category: category, page: page)
    }
}
