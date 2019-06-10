//
//  VideoPlayerNavigator.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/10/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

protocol VideoPlayerNavigatorType {}

struct VideoPlayerNavigator: VideoPlayerNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
