//
//  MovieCategoryType.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

enum CategotyType {
    case popular([Movie])
    case nowPlaying([Movie])
    case upcoming([Movie])
    case topRate([Movie])
    
    var urlString: String {
        switch self {
        case .popular(_):
            return "popular"
        case .nowPlaying(_):
            return "now_playing"
        case .upcoming(_):
            return "upcoming"
        case .topRate(_):
            return "top_rated"
        }
    }
    
    var categoryTitle: String {
        switch self {
        case .popular:
            return "Popular"
        case .nowPlaying:
            return "Now playing"
        case .upcoming:
            return "Upcoming"
        case .topRate:
            return "Top rate"
        }
    }
    
    var movies: [Movie] {
        switch self {
        case .popular(let popularMovies):
            return popularMovies
        case .nowPlaying(let nowPlayingMovies):
            return nowPlayingMovies
        case .upcoming(let upcomingMovies):
            return upcomingMovies
        case .topRate(let topRateMovies):
            return topRateMovies
        }
    }
}
