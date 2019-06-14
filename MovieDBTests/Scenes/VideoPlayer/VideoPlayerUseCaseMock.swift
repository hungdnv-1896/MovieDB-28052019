//
//  VideoPlayerUseCaseMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import RxSwift

final class VideoPlayerUseCaseMock: VideoPlayerUseCaseType {
    
    var getVideoListCalled = false
    
    var getVideoListReturnValue: Observable<[Video]> = {
        let items = [Video().with { $0.id = "1" }]
        return Observable.just(items)
    }()
    
    func getVideoList(movieId: Int) -> Observable<[Video]> {
        getVideoListCalled = true
        return getVideoListReturnValue
    }
}
