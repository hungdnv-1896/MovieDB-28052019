//
//  Assembler.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/27/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//


protocol Assembler: class,
    AppAssembler,
    MainAssembler,
    MoviesAssembler,
    FavoriteAssembler {
    
}

final class DefaultAssembler: Assembler {
    
    
}
