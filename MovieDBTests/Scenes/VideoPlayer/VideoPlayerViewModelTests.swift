//
//  VideoPlayerViewModelTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import RxSwift
import RxBlocking


final class VideoPlayerViewModelTests: XCTestCase {
    private var viewModel: VideoPlayerViewModel!
    private var navigator: VideoPlayerNavigatorMock!
    private var useCase: VideoPlayerUseCaseMock!
    
    private var input: VideoPlayerViewModel.Input!
    private var output: VideoPlayerViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = VideoPlayerNavigatorMock()
        useCase = VideoPlayerUseCaseMock()
        viewModel = VideoPlayerViewModel(useCase: useCase,
                                         navigator: navigator,
                                         movie: Movie())
        disposeBag = DisposeBag()
        input = VideoPlayerViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete()
        )
        output = viewModel.transform(input)
        output.videoList.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getVideoList() {
        loadTrigger.onNext(())
        let videoList = try? output.videoList.toBlocking(timeout: 1).first()
        XCTAssert(useCase.getVideoListCalled)
        XCTAssertEqual(videoList?.count, 1)
    }
}
