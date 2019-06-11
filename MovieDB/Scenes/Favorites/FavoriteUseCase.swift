//
//  FavoriteUseCase.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/28/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import RealmSwift
import Realm

protocol FavoriteUseCaseType {
    func getListFavorite() -> Results<MovieEntity>
    func deleteMovie(id: Int)
}

struct FavoriteUseCase: FavoriteUseCaseType {
    func getListFavorite() -> Results<MovieEntity> {
        let realm = try! Realm()
        let movies = realm.objects(MovieEntity.self)
        return movies
    }
    
    func deleteMovie(id: Int) {
        let realm = try! Realm()
        let objectsToDelete = realm.objects(MovieEntity.self).filter { $0.id == id }
        try! realm.write {
            realm.delete(objectsToDelete)
        }
    }
}
