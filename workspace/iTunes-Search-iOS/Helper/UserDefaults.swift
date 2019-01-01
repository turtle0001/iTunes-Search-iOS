//
//  UserDefaults.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 01/01/2019.
//  Copyright © 2019 joashtubaga. All rights reserved.
//

import Foundation

extension UserDefaults {
  
  static let watchlistMovieKey = "watchlistMovieKey"
  
  func savedMovies() -> [MovieModel] {
    guard let savedMoviesData = UserDefaults.standard.data(forKey: UserDefaults.watchlistMovieKey) else { return [] }
    guard let savedMovies = NSKeyedUnarchiver.unarchiveObject(with: savedMoviesData) as? [MovieModel] else { return [] }
    return savedMovies
  }
  
  func deleteMovie(movie: MovieModel) {
    let movies = savedMovies()
    let filteredMovies = movies.filter { (m) -> Bool in
      return m.trackName != movie.trackName && m.primaryGenreName != movie.primaryGenreName
    }
    let data = NSKeyedArchiver.archivedData(withRootObject: filteredMovies)
    UserDefaults.standard.set(data, forKey: UserDefaults.watchlistMovieKey)
  }
  
}
