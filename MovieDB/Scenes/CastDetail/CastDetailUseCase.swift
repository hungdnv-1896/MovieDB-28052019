//
//  CastDetailUseCase.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol CastDetailUseCaseType {
    func getCastDetail(id: Int) -> Observable<Cast>
    func getMovieListByCast(id: Int) -> Observable<PagingInfo<Movie>>
    func loadMoreMovieListByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>>
}

struct CastDetailUseCase: CastDetailUseCaseType {
    let castDetailRepository: CastDetailRepositoryType
    
    func getCastDetail(id: Int) -> Observable<Cast> {
        return castDetailRepository.getCastDetail(id: id)
    }
    
    func getMovieListByCast(id: Int) -> Observable<PagingInfo<Movie>> {
        return loadMoreMovieListByCast(id: id, page: 1)
    }
    
    func loadMoreMovieListByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>> {
        return castDetailRepository.getListMovieByCast(id: id, page: page)
    }
}
