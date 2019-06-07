//
//  CastDetailRepository.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol CastDetailRepositoryType {
    func getCastDetail(id: Int) -> Observable<Cast>
    func getListMovieByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>>
}

final class CastDetailRepository: CastDetailRepositoryType {
    
    func getCastDetail(id: Int) -> Observable<Cast> {
        let input = API.GetCastDetailInput(id: id)
        return API.shared.getCastDetail(input)
    }
    
    func getListMovieByCast(id: Int, page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.GetMovieListByCastInput(id: id, page: page)
        return API.shared.getListMovieByCast(input)
            .map { output in
                guard let movies = output.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: movies)
        }
    }
}
