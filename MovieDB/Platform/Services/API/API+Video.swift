//
//  API+Video.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/10/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import ObjectMapper

extension API {
    func getVideoList(_ input: GetVideoListInput) -> Observable<GetVideoListOutput> {
        return request(input)
    }
}

extension API {
    final class GetVideoListInput: APIInput {
        init(id: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.APIKey
            ]
            super.init(urlString: API.Urls.getMovieList + String(format: "%ld/videos", id),
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetVideoListOutput: APIOutput {
        private(set) var videos: [Video]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            videos <- map["results"]
        }
    }
}

