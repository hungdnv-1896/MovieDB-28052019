//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/27/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit
import Reusable
import RxDataSources

class MoviesViewController: UIViewController, BindableType {
    
    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var viewModel: MoviesViewModel!
    
    var moviesBanners = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: Methods
    
    private func configView() {
        self.title = "Movies"
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: nil)
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
        
        tableView.do {
            $0.rowHeight = 200
            $0.register(cellType: CategoryCell.self)
            $0.delegate = self
        }
    }
    
    func bindViewModel() {
        let input = MoviesViewModel.Input(
            loadTrigger: Driver.just(())
        )
        
        let output = viewModel.transform(input)
        output.movieCategoryList
            .drive(tableView.rx.items) { tableView, index, category in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: CategoryCell.self).then {
                        $0.category = category
                }
            }
            .disposed(by: rx.disposeBag)
        
        output.movieBannerList
            .drive(headerView)
            .disposed(by: rx.disposeBag)
    }
}

extension MoviesViewController {
    var headerView: Binder<[Movie]> {
        return Binder(self) { viewController, data in
            viewController.moviesBanners = data
        }
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MoviesHeaderView.loadFromNib()
        header.movieBannerList = moviesBanners
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

extension MoviesViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
