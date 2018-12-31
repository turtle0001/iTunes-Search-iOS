//
//  MovieDetailsView.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 31/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
  var movie: MovieModel! {
    didSet {
      titleLabel.text = movie.trackName
      descriptionTextView.text = movie.longDescription
      
      guard let url = URL(string: movie.artworkUrl100 ?? "") else { return }
      thumbnailImageView.sd_setImage(with: url)
    }
  }
  
  @IBAction func handleDismiss(_ sender: Any) {
    self.removeFromSuperview()
  }
  
  @IBOutlet weak var thumbnailImageView: UIImageView!
  
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var titleLabel: UILabel!
}
