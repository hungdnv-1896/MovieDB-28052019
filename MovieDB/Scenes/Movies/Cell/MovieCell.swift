//
//  MovieCell.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var moviePosterImage: UIImageView!
    
    func bindingCell(_ movie: Movie?) {
        if let movie = movie {
            let url = URL(string: API.Urls.baseURLImage + movie.posterPath)
            moviePosterImage?.sd_setImage(with: url,
                                          completed: nil)
        } else {
            moviePosterImage?.image = nil
        }
    }
}
