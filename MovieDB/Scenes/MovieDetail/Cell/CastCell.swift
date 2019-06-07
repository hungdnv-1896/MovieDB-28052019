//
//  CastCell.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class CastCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    
    func bindingCell(_ castViewModel: CastViewModel?) {
        castNameLabel.text = castViewModel?.name
        castImage.sd_setImage(with: castViewModel?.profileImageURL, completed: nil)
    }
}
