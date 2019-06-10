//
//  VideoPlayerViewModel.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/9/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct VideoPlayerViewModel {
    let useCase: VideoPlayerUseCaseType
    let navigator: VideoPlayerNavigatorType
    let movie: Movie
}

extension VideoPlayerViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let videoList: Driver<[Video]>
    }
    
    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let videoList = input.loadTrigger
            .flatMapLatest { _ -> Driver<[Video]> in
                self.useCase.getVideoList(movieId: self.movie.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        return Output(videoList: videoList)
    }
}

