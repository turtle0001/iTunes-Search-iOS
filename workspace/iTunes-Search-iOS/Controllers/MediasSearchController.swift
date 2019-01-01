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
  
  var movies = [MovieModel]()
  
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
    self.definesPresentationContext = true
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }
  
  var timer: Timer?
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    movies = []
    tableView.reloadData()
    
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
      APIService.shared.fetchMovies(searchText: searchText) { (movies) in
        
        self.movies = movies
        self.tableView.reloadData()
      }
    })
  }
  
  struct SearchResults: Decodable {
    let resultCount: Int
    let results: [MovieModel]
  }
  
  fileprivate func setupTableView() {
    tableView.tableFooterView = UIView()
    let nib = UINib(nibName: "MovieCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: cellId)
  }
  
  
  //MARK:- UITableView
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie = self.movies[indexPath.row]
    
    let window = UIApplication.shared.keyWindow
    
    let movieDetailsView = Bundle.main.loadNibNamed("MovieDetailsView", owner: self, options: nil)?.first as! MovieDetailsView
    
    movieDetailsView.movie = movie
    
    movieDetailsView.frame = self.view.frame
    window?.addSubview(movieDetailsView)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieCell
    let movie = self.movies[indexPath.row]
    
    cell.movie = movie
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 116
  }
    
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.text = "Please enter a Movie Search Term"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    return label
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return movies.count > 0 ? 0 : 250
  }
  
  var moviesSearchingView = Bundle.main.loadNibNamed("MoviesSearchingView", owner: self, options: nil)?.first as? UIView
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return moviesSearchingView
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return movies.isEmpty && searchController.searchBar.text?.isEmpty == false ? 200 : 0
  }
}














