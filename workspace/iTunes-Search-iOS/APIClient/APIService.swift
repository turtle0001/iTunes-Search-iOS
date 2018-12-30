//
//  APIService.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 29/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
  
  let baseiTunesSearchURL = "https://itunes.apple.com/search"
  
  //singleton
  static let shared = APIService()
  
  func fetchMovies(searchText: String, completionHandler: @escaping ([MovieModel]) -> ()) {
//    print("Searching for movies...")
    
    let parameters = ["term": searchText, "media": "movie"]
    
    Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
      
      if let err = dataResponse.error {
        print("Failed to contact iTunes Search", err)
        return
      }
      
      guard let data = dataResponse.data else { return }
      do {
        let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
        print(searchResult.resultCount)
        completionHandler(searchResult.results)
        
      } catch let decodeErr {
        print("Failed to decode:", decodeErr)
      }
    }
  }
  
  struct SearchResults: Decodable {
    let resultCount: Int
    let results: [MovieModel]
  }
  
}
