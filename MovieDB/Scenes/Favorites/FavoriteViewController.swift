//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/28/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import Foundation

final class FavoriteViewController: UIViewController, BindableType {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel: FavoriteViewModel!
    
    fileprivate var reloadDataTrigger = PublishSubject<Void>()
    fileprivate var deleteFavoriteTrigger = PublishSubject<Movie>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.do {
            $0.navigationBar.prefersLargeTitles = true
            $0.navigationItem.largeTitleDisplayMode = .always
        }
    }
    
    private func configView() {
        title = "Favorite"
        refreshControl.do {
            $0.tintColor = UIColor.lightGray
            $0.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        }
        tableView.do {
            $0.rowHeight = 150
            $0.register(cellType: FavoriteTableViewCell.self)
            if #available(iOS 10.0, *) {
                $0.refreshControl = refreshControl
            } else {
                $0.addSubview(refreshControl)
            }
        }
        tableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    @objc private func refreshData() {
        reloadDataTrigger.onNext(())
        refreshControl.endRefreshing()
    }
    
    func bindViewModel() {
        let input = FavoriteViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: reloadDataTrigger.asDriverOnErrorJustComplete(),
            selectMovieTrigger: tableView.rx.itemSelected.asDriver(),
            deleteFavoriteTrigger: deleteFavoriteTrigger.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input)
        
        output.listMovie
            .drive(tableView.rx.items) { tableView, index, movie in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: FavoriteTableViewCell.self)
                    .then {
                        $0.bindingCell(MovieViewModel(movie: movie))
                        $0.handleDeleteFavorite = {
                            self.deleteFavoriteTrigger.onNext(movie)
                        }
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.selectMovie
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
