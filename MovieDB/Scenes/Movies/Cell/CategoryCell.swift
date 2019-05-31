//
//  MoviesCategoryCell.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class CategoryCell: UITableViewCell, NibReusable {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var showAllAction: (() -> Void)?
    var showMovieDetail: ((_ movie: Movie) -> Void)?
    var movieList = [Movie]()
    
    var category: CategotyType? {
        didSet {
            categoryLabel.text = category?.getCategoryTitle()
            movieList = category?.getMovies() ?? []
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    
    private func configCell() {
        collectionView.do {
            $0.register(cellType: MovieCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    @IBAction func showAll(_ sender: UIButton) {
        showAllAction?()
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell",
                                                         for: indexPath) as? MovieCell {
            cell.bindingCell(movieList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CategoryCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionView.frame.size.height
        let width = height * 2 / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        showMovieDetail?(movieList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
