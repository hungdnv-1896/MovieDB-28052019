//
//  API+Cast.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/9/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import ObjectMapper

extension API {
    func getCastDetail(_ input: GetCastDetailInput) -> Observable<Cast> {
        return request(input)
    }
    
    func getListMovieByCast(_ input: GetMovieListByCastInput) -> Observable<GetMovieListByCastOutput> {
        return request(input)
    }
}

extension API {
    final class GetCastDetailInput: APIInput {
        init(id: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey
            ]
            super.init(urlString: API.Urls.getCastDetail + String(id),
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetMovieListByCastInput: APIInput {
        init(id: Int, page: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                "with_cast": id,
                "page": page
            ]
            super.init(urlString: API.Urls.getMovieListByCast,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetMovieListByCastOutput: APIOutput {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
}
