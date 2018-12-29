//
//  MovieModel.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 29/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import Foundation

struct MovieModel: Decodable {
  var trackName: String?
  var primaryGenreName: String?
  var artworkUrl100: String?
  var trackPrice: Double?
  
}
