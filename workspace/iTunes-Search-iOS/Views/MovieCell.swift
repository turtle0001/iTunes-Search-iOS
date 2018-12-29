//
//  MovieCell.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 30/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var genreNameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  var movie: MovieModel! {
    didSet {
      
      trackNameLabel.text = movie.trackName
      genreNameLabel.text = movie.primaryGenreName
      
      if let price = movie?.trackPrice {
        priceLabel.text =  "$\(price)"
      } else {
        priceLabel.text = ""
      }

      
    }
  }
    
}
