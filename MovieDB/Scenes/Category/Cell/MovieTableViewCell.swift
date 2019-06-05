//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/1/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindingCell(_ movie: Movie?) {
        guard let movie = movie else { return }
        nameLabel.text = movie.title
        let url = URL(string: API.Urls.baseURLImage + movie.posterPath)
        posterImage?.sd_setImage(with: url,
                                          completed: nil)
    }
}
