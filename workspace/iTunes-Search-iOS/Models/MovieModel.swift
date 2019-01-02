//
//  MovieModel.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 29/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import Foundation

class MovieModel: NSObject, Decodable, NSCoding {
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(trackName ?? "", forKey: "trackNameKey")
    aCoder.encode(primaryGenreName ?? "", forKey: "primaryGenreNameKey")
    aCoder.encode(artworkUrl100 ?? "", forKey: "artworkKey")
    aCoder.encode(longDescription ?? "", forKey: "longDescripKey")
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.trackName = aDecoder.decodeObject(forKey: "trackNameKey") as? String
    self.primaryGenreName = aDecoder.decodeObject(forKey: "primaryGenreNameKey") as? String
    self.artworkUrl100 = aDecoder.decodeObject(forKey: "artworkKey") as? String
    self.longDescription = aDecoder.decodeObject(forKey: "longDescripKey") as? String
  }

  var trackName: String?
  var primaryGenreName: String?
  var artworkUrl100: String?
  var trackPrice: Double?
  var longDescription: String?
  
}



