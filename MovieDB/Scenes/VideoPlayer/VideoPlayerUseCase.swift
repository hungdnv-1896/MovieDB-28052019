//
//  VideoPlayerUseCase.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/9/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol VideoPlayerUseCaseType {
    func getVideoList(movieId: Int) -> Observable<[Video]>
}

struct VideoPlayerUseCase: VideoPlayerUseCaseType {
    let videoRepository: VideoRepositoryType
    
    func getVideoList(movieId: Int) -> Observable<[Video]> {
        return videoRepository.getVideoList(id: movieId)
    }
}
