//
//  MoviesHeaderView.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/30/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class MoviesHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var pagerView: FSPagerView!
    
    var movieBannerList: [Movie] = [] {
        didSet {
            self.pagerView.reloadData()
        }
    }
    
    var handleShowMovieDetail: ((_ index: Int) -> Void )?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        pagerView.do {
            $0.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            $0.itemSize = FSPagerView.automaticSize
            $0.decelerationDistance = 1
            $0.delegate = self
            $0.dataSource = self
        }
    }
}

extension MoviesHeaderView: FSPagerViewDataSource, FSPagerViewDelegate {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return movieBannerList.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = URL(string: API.Urls.baseURLImage + self.movieBannerList[index].backdropPath)
        cell.imageView?.do {
            $0.sd_setImage(with: url, completed: nil)
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.do {
            $0.deselectItem(at: index, animated: true)
            $0.scrollToItem(at: index, animated: true)
        }
        handleShowMovieDetail?(index)
    }
}

