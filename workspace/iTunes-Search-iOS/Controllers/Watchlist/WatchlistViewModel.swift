//
//  WatchlistViewModel.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 11/23/21.
//  Copyright © 2021 joashtubaga. All rights reserved.
//

import Foundation

class WatchlistViewModel: WatchlistViewModelProtocol {
  private var movies: [MovieModel] = []
  
  private(set) var itemVMs: [WatchlistCellViewModelProtocol] = []
}

// MARK: - Methods

extension WatchlistViewModel {
  func refreshData() {
    movies = UserDefaults.standard.savedMovies()
    itemVMs = movies.map(WatchlistCellViewModel.init)
  }
  
  func removeItem(at index: Int) {
    let movie = movies[index]
    
    movies.remove(at: index)
    
    UserDefaults.standard.deleteMovie(movie: movie)
  }
  
  func detailsVM(at index: Int) -> MovieDetailsViewModelProtocol {
    let movie = movies[index]
    return MovieDetailsViewModel(movie: movie)
  }
}
