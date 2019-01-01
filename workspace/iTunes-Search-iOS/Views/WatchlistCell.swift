//
//  WatchlistCell.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 01/01/2019.
//  Copyright © 2019 joashtubaga. All rights reserved.
//

import UIKit

class WatchlistCell: UICollectionViewCell {
  
  var movie: MovieModel! {
    didSet {
      trackNameLabel.text = movie.trackName
      genreNameLabel.text = movie.primaryGenreName
      
      let url = URL(string: movie.artworkUrl100 ?? "")
      imageView.sd_setImage(with: url)
    }
  }
  
  let imageView = UIImageView(image: UIImage(named: "movie")) // for some reason the shorter alternative won't work
  let trackNameLabel = UILabel()
  let genreNameLabel = UILabel()
  
  fileprivate func stylizeUI() {
    trackNameLabel.text = "Track Name"
    trackNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    genreNameLabel.text = "Genre"
    genreNameLabel.font = UIFont.systemFont(ofSize: 14)
    genreNameLabel.textColor = .lightGray
  }
  
  fileprivate func setupViews() {
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    
    let stackView = UIStackView(arrangedSubviews: [imageView, trackNameLabel, genreNameLabel])
    
    stackView.axis = .vertical
    // enables auto layout
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(stackView)
    
    stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    stylizeUI()
    setupViews()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
