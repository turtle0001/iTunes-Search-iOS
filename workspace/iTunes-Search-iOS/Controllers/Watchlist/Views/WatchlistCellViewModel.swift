//
//  WatchlistCellViewModel.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 11/23/21.
//  Copyright © 2021 joashtubaga. All rights reserved.
//

import Foundation

class WatchlistCellViewModel: WatchlistCellViewModelProtocol {
  private let movie: MovieModel

  init(movie: MovieModel) {
    self.movie = movie
  }
}

// MARK: - Getters

extension WatchlistCellViewModel {
  var trackName: String? { movie.trackName }
  var genre: String? { movie.primaryGenreName }

  var imageURL: URL? {
    guard let string = movie.artworkUrl100 else {
      return nil
    }
    return URL(string: string)
  }
}
