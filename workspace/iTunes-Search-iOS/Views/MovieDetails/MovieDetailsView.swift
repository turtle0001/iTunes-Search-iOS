//
//  MovieDetailsView.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 31/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
  var viewModel: MovieDetailsViewModelProtocol! {
    didSet { refresh() }
  }
  
  var onDismissTap: (() -> Void)?

  @IBOutlet var watchListButtonItem: UIButton!
  @IBOutlet var thumbnailImageView: UIImageView!
  @IBOutlet var descriptionTextView: UITextView!
  @IBOutlet var titleLabel: UILabel!
}

// MARK: - Actions

private extension MovieDetailsView {
  @IBAction
  func handleDismissButton(_ sender: Any) {
    removeFromSuperview()
    onDismissTap?()
  }

  @IBAction
  func addToWatchlistButton(_ sender: UIButton) {
    viewModel.toggleFavorite()
    refreshWatchListButtonItem()

    if viewModel.isFavorited {
      showBadgeHighlight()
    }
  }
}

// MARK: - Refresh

private extension MovieDetailsView {
  func refresh() {
    refreshWatchListButtonItem()
    
    titleLabel.text = viewModel.titleText
    descriptionTextView.text = viewModel.descriptionText

    if let url = viewModel.imageURL {
      thumbnailImageView.sd_setImage(with: url)
    }
  }

  func refreshWatchListButtonItem() {
    var imageName = "watchlist"

    if viewModel.isFavorited {
      imageName = "heart"
    }

    let image = UIImage(named: imageName)
    watchListButtonItem.setImage(image, for: .normal)
  }
}

// MARK: - Helpers

private extension MovieDetailsView {
  func showBadgeHighlight() {
    UIApplication.mainTabBarController()?.viewControllers?[1].tabBarItem.badgeValue = "New"
  }
}
