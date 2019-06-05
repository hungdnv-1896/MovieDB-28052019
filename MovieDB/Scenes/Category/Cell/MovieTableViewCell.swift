//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/1/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class MovieTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func bindingCell(_ movieViewModel: MovieViewModel?) {
        nameLabel.text = movieViewModel?.name ?? ""
        posterImage.sd_setImage(with: movieViewModel?.posterImageURL, completed: nil)
    }
}
