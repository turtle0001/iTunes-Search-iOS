//
//  MovieDetailsViewModel.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 11/23/21.
//  Copyright © 2021 joashtubaga. All rights reserved.
//

import Foundation

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
  private var favoriteMovies: [MovieModel]
  
  private let movie: MovieModel

  init(movie: MovieModel) {
    self.movie = movie
    
    favoriteMovies = UserDefaults.standard.savedMovies()
  }
}

// MARK: - Methods

extension MovieDetailsViewModel {
  func toggleFavorite() {
    if isFavorited {
      unmarkAsFavorite()
    } else {
      markAsFavorite()
    }
  }
}

// MARK: - Helpers

private extension MovieDetailsViewModel {
  func markAsFavorite() {
    favoriteMovies.append(movie)
    saveFavoriteMovies()
  }
  
  func unmarkAsFavorite() {
    guard
      let index = favoriteMovies.firstIndex(
        where: { $0.trackName == movie.trackName }
      )
    else {
      return
    }
    
    favoriteMovies.remove(at: index)
    saveFavoriteMovies()
  }
  
  func saveFavoriteMovies() {
    let data = NSKeyedArchiver.archivedData(
      withRootObject: favoriteMovies
    )
    
    let key = UserDefaults.watchlistMovieKey
    UserDefaults.standard.set(data, forKey: key)
  }
}

// MARK: - Getters

extension MovieDetailsViewModel {
  var isFavorited: Bool {
    favoriteMovies.contains(
      where: { $0.trackName == movie.trackName }
    )
  }
  
  var titleText: String? { movie.trackName }
  var descriptionText: String? { movie.longDescription }
  
  var imageURL: URL? {
    guard let string = movie.artworkUrl100 else {
      return nil
    }
    return URL(string: string)
  }
}
