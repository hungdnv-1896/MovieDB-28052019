//
//  API+Repo.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 5/29/19.
//  Copyright © 2018 Framgia. All rights reserved.
//

import ObjectMapper

extension API {
    func getMovieList(_ input: GetMovieListInput) -> Observable<GetMovieListOutput> {
        return request(input)
    }
    
    func searchMovieList(_ input: SearchMovieListInput) -> Observable<SearchMovieListOutput> {
        return request(input)
    }
    
    func getMovieDetail(_ input: GetMovieDetailInput) -> Observable<Movie> {
        return request(input)
    }
}

// MARK: - GetRepoList
extension API {
    final class GetMovieListInput: APIInput {
        init(category: CategoryType, page: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                "page": page
            ]
            super.init(urlString: API.Urls.getMovieList + category.urlString,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetMovieListOutput: APIOutput {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
    
    final class SearchMovieListInput: APIInput {
        init(keySearch: String, page: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                "query": keySearch,
                "page": page
            ]
            super.init(urlString: API.Urls.searchMovie,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class SearchMovieListOutput: APIOutput {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
    
    final class GetMovieDetailInput: APIInput {
        init(id: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey,
                "append_to_response": "videos,credits"
                
            ]
            super.init(urlString: API.Urls.getMovieList + String(id),
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
}

