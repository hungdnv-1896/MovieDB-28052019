//
//  CategoryViewController.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/1/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit
import Reusable

final class CategoryViewController: UIViewController, BindableType {

    @IBOutlet weak var tableView: RefreshTableView!
    
    var viewModel: CategoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configView() {
        self.title = viewModel.category.categoryTitle
        tableView.do {
            $0.rowHeight = 150
            $0.register(cellType: MovieTableViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = CategoryViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.loadMoreTopTrigger,
            loadMoreTrigger: tableView.loadMoreBottomTrigger,
            selectMovieTrigger: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input)
        
        output.movieList
            .drive(tableView.rx.items) { tableView, index, movie in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: MovieTableViewCell.self)
                    .then {
                        $0.bindingCell(MovieViewModel(movie: movie))
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
        
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.isEmptyData
            .drive(tableView.isEmptyData)
            .disposed(by: rx.disposeBag)
    }
}

extension CategoryViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
