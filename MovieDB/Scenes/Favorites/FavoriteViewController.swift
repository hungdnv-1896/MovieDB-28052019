//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/28/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import Foundation

final class FavoriteViewController: UIViewController, BindableType {
    
    @IBOutlet weak var tableView: RefreshTableView!
    
    var viewModel: FavoriteViewModel!
    
    fileprivate var reloadDataTrigger = PublishSubject<Void>()
    fileprivate var deleteFavoriteTrigger = PublishSubject<MovieFavorite>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.do {
            $0.navigationBar.prefersLargeTitles = true
            $0.navigationItem.largeTitleDisplayMode = .always
        }
    }
    
    private func configView() {
        title = "Favorites"
        tableView.do {
            $0.rowHeight = 150
            $0.register(cellType: FavoriteTableViewCell.self)
        }
        tableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        let input = FavoriteViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.loadMoreTopTrigger,
            loadMoreTrigger: tableView.loadMoreBottomTrigger,
            selectMovieTrigger: tableView.rx.itemSelected.asDriver(),
            deleteFavoriteTrigger: deleteFavoriteTrigger.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input)
        
        output.movieFavoriteList
            .drive(tableView.rx.items) { [unowned self] tableView, index, movieFavorite in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: FavoriteTableViewCell.self)
                    .then {
                        $0.bindingCell(MovieFavoriteViewModel(movieFavorite: movieFavorite))
                        $0.handleDeleteFavorite = {
                            self.deleteFavoriteTrigger.onNext(movieFavorite)
                        }
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.selectedMovie
            .drive()
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
        
        output.deleteFavorite
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension FavoriteViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}


extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
