//
//  MovieDetailsView.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 31/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
  
  let watchlistMovieKey = "watchlistMovieKey"

  @IBOutlet weak var watchListButtonItem: UIButton!
  
  var movie: MovieModel! {
    didSet {
      titleLabel.text = movie.trackName
      descriptionTextView.text = movie.longDescription
      
      guard let url = URL(string: movie.artworkUrl100 ?? "") else { return }
      thumbnailImageView.sd_setImage(with: url)
    }
  }
  
  @IBAction func handleDismissButton(_ sender: Any) {
    self.removeFromSuperview()
  }
  
  @IBAction func addToWatchlistButton(_ sender: UIButton) {
    let savedMovies = UserDefaults.standard.savedMovies()
    let hasFavorited = savedMovies.index(where: { $0.trackName == self.movie?.trackName && $0.primaryGenreName == self.movie?.primaryGenreName }) != nil
    
    if hasFavorited {
      // setting up our heart icon
      watchListButtonItem.setImage(UIImage(named: "heart"), for: .normal)
    } else {
      guard let movie = self.movie else { return }
      
      var listOfMovies = UserDefaults.standard.savedMovies()
      listOfMovies.append(movie)
      let data = NSKeyedArchiver.archivedData(withRootObject: listOfMovies)
      
      UserDefaults.standard.set(data, forKey: UserDefaults.watchlistMovieKey)
      
      showBadgeHighlight()
    }
  
     watchListButtonItem.setImage(UIImage(named: "heart"), for: .normal)
  }
  
  fileprivate func showBadgeHighlight() {
    UIApplication.mainTabBarController()?.viewControllers?[1].tabBarItem.badgeValue = "New"
  }
  
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var titleLabel: UILabel!
}
