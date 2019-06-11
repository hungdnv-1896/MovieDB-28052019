//
//  VideoRepository.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/10/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol VideoRepositoryType {
    func getVideoList(id: Int) -> Observable<[Video]>
}

final class VideoRepository: VideoRepositoryType {
    func getVideoList(id: Int) -> Observable<[Video]> {
        let input = API.GetVideoListInput(id: id)
        return API.shared.getVideoList(input)
            .map { $0.videos ?? [] }
    }
}
