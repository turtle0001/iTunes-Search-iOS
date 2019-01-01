//
//  WatchlistController.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 01/01/2019.
//  Copyright © 2019 joashtubaga. All rights reserved.
//

import UIKit

class WatchlistController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  fileprivate let cellId = "cellId"
  
  var movies = UserDefaults.standard.savedMovies()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    movies = UserDefaults.standard.savedMovies()
    collectionView?.reloadData()
    UIApplication.mainTabBarController()?.viewControllers?[1].tabBarItem.badgeValue = nil
  }
  
  fileprivate func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(WatchlistCell.self, forCellWithReuseIdentifier: cellId)
    
    // Added to delete a movie by using a UILongPressGestureRecognizer
    let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
    collectionView?.addGestureRecognizer(gesture)
  }
  
  @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {

    
    let location = gesture.location(in: collectionView)
    
    guard let selectedIndexPath = collectionView?.indexPathForItem(at: location) else { return }
    
    print(selectedIndexPath.item)
    
    let alertController = UIAlertController(title: "Remove Movie?", message: nil, preferredStyle: .actionSheet)
    
    alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
      let selectedMovie = self.movies[selectedIndexPath.item]
      // remove the movie object from collection view
      self.movies.remove(at: selectedIndexPath.item)
      self.collectionView?.deleteItems(at: [selectedIndexPath])
      // also remove your watchlisted movie from UserDefaults
      // The simulator doesn't delete immediately, test with your physical iPhone devices
      UserDefaults.standard.deleteMovie(movie: selectedMovie)
    }))
    
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    present(alertController, animated: true)
  }
  
  // MARK:- UICollectionView Delegate / Spacing Methods
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = self.movies[indexPath.row]
    
    let window = UIApplication.shared.keyWindow
    
    let movieDetailsView = Bundle.main.loadNibNamed("MovieDetailsView", owner: self, options: nil)?.first as! MovieDetailsView
    
    movieDetailsView.movie = movie
    
    movieDetailsView.frame = self.view.frame
    window?.addSubview(movieDetailsView)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WatchlistCell
    
    cell.movie = self.movies[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (view.frame.width - 3 * 16) / 2
    
    return CGSize(width: width, height: width + 46)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
  
  
  
}
