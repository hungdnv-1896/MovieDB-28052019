//
//  SearchMovieViewController.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/4/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class SearchMovieViewController: UIViewController, BindableType {

    @IBOutlet weak var tableView: RefreshTableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: SearchMovieViewModel!
    var searchTerms = ""
    var searchWasCancelled = false
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.searchController?.isActive = false
    }
    
    private func configView() {
        self.do {
            $0.definesPresentationContext = true
            $0.title = "Search Movie"
        }
        
        self.searchController.do {
            $0.searchBar.delegate = self
            $0.searchBar.placeholder = "Enter keyword"
        }
        navigationItem.do {
            $0.searchController = searchController
            $0.hidesSearchBarWhenScrolling = false
            $0.searchController?.obscuresBackgroundDuringPresentation = false
        }
        tableView.do {
            $0.rowHeight = 150
            $0.register(cellType: MovieTableViewCell.self)
        }
    }
    
    func bindViewModel() {
        let loadTrigger = searchController.searchBar.rx.text.orEmpty
            .asDriver()
            .throttle(0.5)
            .distinctUntilChanged()
        
        let input = SearchMovieViewModel.Input(
            loadTrigger: loadTrigger,
            reloadTrigger: tableView.loadMoreTopTrigger,
            loadMoreTrigger: tableView.loadMoreBottomTrigger,
            selectMovieTrigger: tableView.rx.itemSelected.asDriver()
        )
        
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

extension SearchMovieViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

extension SearchMovieViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchWasCancelled = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTerms = searchBar.text ?? " "
        searchWasCancelled = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchWasCancelled {
            searchBar.text = self.searchTerms
        } else {
            searchTerms = searchBar.text ?? " "
        }
    }
}
