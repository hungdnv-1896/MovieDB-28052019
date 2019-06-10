//
//  VideoPlayerViewController.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/9/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

final class VideoPlayerViewController: UIViewController, BindableType {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: VideoPlayerViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
    }
    
    private func configView() {
        title = "Trailers"
        tableView.do {
            $0.estimatedRowHeight = 200
            $0.register(cellType: VideoPlayerTableViewCell.self)
        }
    }

    func bindViewModel() {
        let input = VideoPlayerViewModel.Input(
            loadTrigger: Driver.just(())
        )
        
        let output = viewModel.transform(input)
        
        output.videoList
            .drive(tableView.rx.items) { tableView, index, video in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: VideoPlayerTableViewCell.self)
                    .then {
                        $0.bindingCell(VideoViewModel(video: video))
                    }
            }
            .disposed(by: rx.disposeBag)
    }
}

extension VideoPlayerViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
