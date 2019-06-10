//
//  ReviewTableViewCell.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var reviewerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func bindingCell(_ reviewModel: ReviewModel?) {
        reviewerLabel.text = reviewModel?.author ?? ""
        contentLabel.text = reviewModel?.content ?? ""
    }
}
