//
//  Utils.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/3/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

func after(interval: TimeInterval, completion: (() -> Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        completion?()
    }
}
