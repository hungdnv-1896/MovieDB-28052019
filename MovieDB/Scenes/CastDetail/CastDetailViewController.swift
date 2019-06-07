//
//  CastDetailViewController.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class CastDetailViewController: UIViewController, BindableType {
    
    @IBOutlet weak var castProfileImage: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var knowForLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel: CastDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func configView() {
        movieTableView.do {
            $0.rowHeight = 120
            $0.register(cellType: MovieTableViewCell.self)
        }
        scrollView.do {
            $0.contentInset = UIEdgeInsets(top: -44, left: 0, bottom: 0, right: 0)
        }
    }
    
    func bindViewModel() {
        let input = CastDetailViewModel.Input(
            loadTrigger: Driver.just(()),
            backScreenTrigger: backButton.rx.tap.asDriverOnErrorJustComplete(),
            selectMovieTrigger: movieTableView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.castDetail
            .map { CastViewModel(cast: $0) }
            .drive(cast)
            .disposed(by: rx.disposeBag)
        
        output.movieList
            .drive(movieTableView.rx.items) { tableView, index, movie in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: MovieTableViewCell.self)
                    .then {
                        $0.bindingCell(MovieViewModel(movie: movie))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.backScreen
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
}

extension CastDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

// MARK: - Binding Model
extension CastDetailViewController {
    var cast: Binder<CastViewModel> {
        return Binder(self) { viewController, castDetailModel in
            viewController.do {
                $0.castProfileImage.sd_setImage(with: castDetailModel.profileImageURL, completed: nil)
                $0.castNameLabel.text = castDetailModel.name
                $0.knowForLabel.text = String(format: "Known For: %@", castDetailModel.knowFor)
                $0.genderLabel.text = String(format: "Gender: %@", castDetailModel.gender.title)
                $0.birthdayLabel.text = String(format: "Birthday: %@", castDetailModel.birthday)
                $0.placeOfBirthLabel.text = String(format: "Place of birth: %@", castDetailModel.placeOfBirth)
                $0.biographyLabel.text = castDetailModel.biography
            }
        }
    }
}
