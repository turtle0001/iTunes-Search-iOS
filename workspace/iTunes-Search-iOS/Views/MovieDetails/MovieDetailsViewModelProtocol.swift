//
//  MovieDetailsViewModelProtocol.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 11/23/21.
//  Copyright © 2021 joashtubaga. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
  var isFavorited: Bool { get }
  
  var titleText: String? { get }
  var descriptionText: String? { get }
  var imageURL: URL? { get }
  
  func toggleFavorite()
}
