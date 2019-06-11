//
//  VideoPlayerTableViewCell.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/10/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

final class VideoPlayerTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindingCell(_ videoViewModel: VideoViewModel?) {
        nameLabel.text = videoViewModel?.name
        playerView.load(withVideoId: videoViewModel?.key ?? "")
    }
}
