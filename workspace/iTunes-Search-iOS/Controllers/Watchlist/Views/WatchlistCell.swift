//
//  WatchlistCell.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 01/01/2019.
//  Copyright © 2019 joashtubaga. All rights reserved.
//

import UIKit

class WatchlistCell: UICollectionViewCell {
  var viewModel: WatchlistCellViewModelProtocol! {
    didSet { refresh() }
  }
  
  lazy var imageView = { UIImageView(image: UIImage(named: "movie")) }()
  lazy var trackNameLabel = { UILabel() }()
  lazy var genreNameLabel = { UILabel() }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup

private extension WatchlistCell {
  func setup() {
    setupLayout()
  }

  func setupLayout() {
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true

    let stackView = UIStackView()
    stackView.axis = .vertical
    
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(trackNameLabel)
    stackView.addArrangedSubview(genreNameLabel)

    // enables auto layout
    stackView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(stackView)

    stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }

  func setupValues() {
    trackNameLabel.text = "Track Name"
    trackNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

    genreNameLabel.text = "Genre"
    genreNameLabel.font = UIFont.systemFont(ofSize: 14)
    genreNameLabel.textColor = .lightGray
  }
}

// MARK: - Refresh

private extension WatchlistCell {
  func refresh() {
    if let url = viewModel.imageURL {
      imageView.sd_setImage(with: url)
    }
    
    trackNameLabel.text = viewModel.trackName
    genreNameLabel.text = viewModel.genre
  }
}
