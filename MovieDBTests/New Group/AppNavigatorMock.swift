//
//  AppNavigatorMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB

final class AppNavigatorMock: AppNavigatorType {
    
    var toMainCalled = false
    
    func toMain() {
        toMainCalled = true
    }
    
}
