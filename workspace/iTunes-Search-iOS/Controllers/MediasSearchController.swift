//
//  MediasSearchController.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 29/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import UIKit

class MediasSearchController: UITableViewController,  UISearchBarDelegate{
  let podcasts = [
    PodcastModel(name: "Sample podcast 1", artistName: "Joash"),
    PodcastModel(name: "Sample podcast 2", artistName: "Tubaga"),
    ]
  
  let cellId = "cellId"
  
  // UISearchController Implementation
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
    print(searchText)
  }
  
  fileprivate func setupTableView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  //MARK:- UITableView
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return podcasts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    
    let podcast = self.podcasts[indexPath.row]
    cell.textLabel?.text = "\(podcast.name)\n\(podcast.artistName)"
    cell.textLabel?.numberOfLines = -1
    cell.imageView?.image = #imageLiteral(resourceName: "appicon")
    
    return cell
  }
}
