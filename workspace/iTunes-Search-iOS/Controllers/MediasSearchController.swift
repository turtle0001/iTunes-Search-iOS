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
    MovieModel(trackName: "Sample movie 1", primaryGenreName: "Action", artworkUrl100: nil, trackPrice: 99.99),
    MovieModel(trackName: "Sample movie 2", primaryGenreName: "Comedy", artworkUrl100: nil, trackPrice: 9.99)
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
    APIService.shared.fetchMovies(searchText: searchText) { (movies) in
      
      self.movies = movies
      self.tableView.reloadData()
    }
  }
  
  struct SearchResults: Decodable {
    let resultCount: Int
    let results: [MovieModel]
  }
  
  fileprivate func setupTableView() {
    let nib = UINib(nibName: "MovieCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: cellId)
  }
  
  //MARK:- UITableView
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieCell
    
    let movie = self.movies[indexPath.row]
    
    cell.movie = movie
    
//    let movie = self.movies[indexPath.row]
//    cell.textLabel?.text = "\(movie.trackName ?? "")\n\(movie.artistName ?? "")"
//    cell.textLabel?.numberOfLines = -1
//    cell.imageView?.image = #imageLiteral(resourceName: "appicon")
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 116
  }
  
}














