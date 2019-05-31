//
//  MovieCategoryType.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

//enum MovieCategoryType: String {
//    case popular = "popular"
//    case nowPlaying = "now_playing"
//    case upcoming = "upcoming"
//    case topRate = "top_rated"
//
//    func getCategoryTitle() -> String {
//        var title = ""
//        switch self {
//        case .popular:
//            title = "Popular"
//        case .nowPlaying:
//            title = "Now playing"
//        case .upcoming:
//            title = "Upcoming"
//        case .topRate:
//            title = "Top rate"
//        }
//        return title
//    }
//}

enum CategotyType {
    case popular([Movie])
    case nowPlaying([Movie])
    case upcoming([Movie])
    case topRate([Movie])
    
    func getUrlString() -> String {
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
    
    func getCategoryTitle() -> String {
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
    
    func getMovies() -> [Movie] {
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
