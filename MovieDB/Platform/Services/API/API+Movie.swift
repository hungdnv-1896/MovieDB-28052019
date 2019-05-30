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
}

// MARK: - GetRepoList
extension API {
    final class GetMovieListInput: APIInput {
        init(category: MovieCategoryType, page: Int) {
            let params: JSONDictionary = [
                "api_key": APIKey,
                "page": page
            ]
            super.init(urlString: API.Urls.getMovieList + category.rawValue,
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
}

