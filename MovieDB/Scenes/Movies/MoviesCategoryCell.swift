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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func configCell() {
        collectionView.do {
            $0.register(cellType: MovieCell.self)
        }
    }
    
    func bindingViewModel() {
//        if let viewModel = viewModel {
//
//        } else {
//
//        }
    }
    
    @IBAction func showAll(_ sender: UIButton) {
        
    }
}
