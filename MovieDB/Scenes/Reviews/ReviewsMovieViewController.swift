//
//  ReviewsMovieViewController.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class ReviewsMovieViewController: UIViewController, BindableType {

    @IBOutlet weak var tableView: RefreshTableView!
    
    var viewModel: ReviewsMovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        title = "Reviews"
        tableView.do {
            $0.estimatedRowHeight = 150
            $0.register(cellType: ReviewTableViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = ReviewsMovieViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.loadMoreTopTrigger,
            loadMoreTrigger: tableView.loadMoreBottomTrigger)
        
        let output = viewModel.transform(input)
        
        output.reviewList
            .drive(tableView.rx.items) { tableView, index, review in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: ReviewTableViewCell.self)
                    .then {
                        $0.bindingCell(ReviewViewModel(review: review))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.refreshing
            .drive(tableView.loadingMoreTop)
            .disposed(by: rx.disposeBag)
        
        output.loadingMore
            .drive(tableView.loadingMoreBottom)
            .disposed(by: rx.disposeBag)
        
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.isEmptyData
            .drive(tableView.isEmptyData)
            .disposed(by: rx.disposeBag)
    }

}

extension ReviewsMovieViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
