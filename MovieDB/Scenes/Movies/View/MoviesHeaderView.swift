//
//  MoviesHeaderView.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/30/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

class MoviesHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var pagerView: FSPagerView!
    
    var movieBannerList: [Movie] = [] {
        didSet {
            self.pagerView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView() {
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.pagerView.itemSize = FSPagerView.automaticSize
        self.pagerView.decelerationDistance = 1
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
    }
}

extension MoviesHeaderView: FSPagerViewDataSource, FSPagerViewDelegate {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return movieBannerList.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = URL(string: API.Urls.baseURLImage + self.movieBannerList[index].backdropPath)
        cell.imageView?.sd_setImage(with: url, completed: nil)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
}

