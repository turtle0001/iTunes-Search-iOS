//
//  PodcastsSearchController.swift
//  PodcastsCourseLBTA
//
//  Created by Brian Voong on 2/14/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit
import Alamofire

class MediasSearchController: UITableViewController, UISearchBarDelegate {
  
  var movies = [
    MovieModel(trackName: "Sample movie 1", artistName: "Joash"),
    MovieModel(trackName: "Sample movie 2", artistName: "Tubaga"),
    ]
  
  let cellId = "cellId"
  
  // lets implement a UISearchController
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSearchBar()
    setupTableView()
  }
  
  //MARK:- Setup Work
  
  fileprivate func setupSearchBar() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  
    // Alamofire implementation to search iTunes API
    
    let url = "https://itunes.apple.com/search"
    let parameters = ["term": searchText, "media": "movie"]
    
    Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
      
      if let err = dataResponse.error {
        print("Failed to contact yahoo", err)
        return
      }
      
      guard let data = dataResponse.data else { return }
      do {
        let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
        self.movies = searchResult.results
        self.tableView.reloadData()
      } catch let decodeErr {
        print("Failed to decode:", decodeErr)
      }
      
    }
  }
  
  struct SearchResults: Decodable {
    let resultCount: Int
    let results: [MovieModel]
  }
  
  fileprivate func setupTableView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  //MARK:- UITableView
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    
    let movie = self.movies[indexPath.row]
    cell.textLabel?.text = "\(movie.trackName ?? "")\n\(movie.artistName ?? "")"
    cell.textLabel?.numberOfLines = -1
    cell.imageView?.image = #imageLiteral(resourceName: "appicon")
    
    return cell
  }
}














