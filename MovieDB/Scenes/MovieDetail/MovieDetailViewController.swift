//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/5/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit
import Cosmos

final class MovieDetailViewController: UIViewController, BindableType {
    
    // MARK: Outlets
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var showReviewsButton: UIButton!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    var viewModel: MovieDetailViewModel!
    
    fileprivate var showCastDetailTrigger = PublishSubject<IndexPath>()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()	
    }
    
    override func loadView() {
        super.loadView()
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Functions
    
    private func configView() {
        self.title = self.viewModel.movie.title
        castCollectionView.do {
            $0.delegate = self
            $0.register(cellType: CastCell.self)
        }
    }
    
    func bindViewModel() {
        let input = MovieDetailViewModel.Input(
            loadTrigger: Driver.just(()),
            showCastDetailTrigger: showCastDetailTrigger.asDriverOnErrorJustComplete(),
            backScreenTrigger: backButton.rx.tap.asDriverOnErrorJustComplete(),
            showReviewsTrigger: showReviewsButton.rx.tap.asDriverOnErrorJustComplete(),
            playTrailerTrigger: trailerButton.rx.tap.asDriverOnErrorJustComplete(),
            addFavoriteTrigger: addFavoriteButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.movieDetail
            .map { MovieViewModel(movie: $0) }
            .drive(model)
            .disposed(by: rx.disposeBag)
        
        output.castList
            .drive(castCollectionView.rx.items) { collectionView, index, cast in
                return collectionView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: CastCell.self)
                    .then {
                        $0.bindingCell(CastViewModel(cast: cast))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.backScreen
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.showCastDetail
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.showReviews
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.playTrailer
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.addFavorite
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Binding Model
extension MovieDetailViewController {
    var model: Binder<MovieViewModel> {
        return Binder(self) { viewController, movieDetailModel in
            viewController.do {
                $0.backDropImage.sd_setImage(with: movieDetailModel.backdropImageURL, completed: nil)
                $0.posterImage.sd_setImage(with: movieDetailModel.posterImageURL, completed: nil)
                $0.movieNameLabel.text = movieDetailModel.name
                $0.overviewLabel.text = movieDetailModel.overview
                $0.timeLabel.text = String(format: "%ldm", movieDetailModel.runtime)
                $0.rateView.rating = (movieDetailModel.voteAverage)
            }
        }
    }
}

extension MovieDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = height / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showCastDetailTrigger.onNext(IndexPath(item: indexPath.row, section: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
