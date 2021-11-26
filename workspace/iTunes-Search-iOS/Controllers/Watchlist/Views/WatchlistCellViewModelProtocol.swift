//
//  WatchlistCellViewModelProtocol.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 11/23/21.
//  Copyright © 2021 joashtubaga. All rights reserved.
//

import Foundation

protocol WatchlistCellViewModelProtocol {
  var trackName: String? { get }
  var genre: String? { get }
  var imageURL: URL? { get }
}
