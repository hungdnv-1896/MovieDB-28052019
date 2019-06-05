//
//  MovieCell.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var moviePosterImage: UIImageView!
    
    func bindingCell(_ movieViewModel: MovieViewModel?) {
        moviePosterImage?.sd_setImage(with: movieViewModel?.posterImageURL, completed: nil)
    }
}
