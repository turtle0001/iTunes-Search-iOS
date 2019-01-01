//
//  MovieCell.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 30/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
  
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var genreNameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  var movie: MovieModel! {
    didSet {
      trackNameLabel.text = movie.trackName
      genreNameLabel.text = movie.primaryGenreName
      priceLabel.text = "$\(movie.trackPrice ?? 0)"
      
      guard let url = URL(string: movie.artworkUrl100 ?? "") else { return }
      // Handle the loading and caching of web images
      movieImageView.sd_setImage(with: url, completed: nil)
      
    }
  }
    
}
