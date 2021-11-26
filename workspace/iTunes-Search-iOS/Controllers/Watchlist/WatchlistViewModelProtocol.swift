//
//  WatchlistViewModelProtocol.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 11/23/21.
//  Copyright © 2021 joashtubaga. All rights reserved.
//

import Foundation

protocol WatchlistViewModelProtocol {
  var itemVMs: [WatchlistCellViewModelProtocol] { get }
  
  func refreshData()
  
  func removeItem(at index: Int)
  
  func detailsVM(at index: Int) -> MovieDetailsViewModelProtocol
}
