//
//  WatchlistController.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 01/01/2019.
//  Copyright © 2019 joashtubaga. All rights reserved.
//

import UIKit

class WatchlistController: UICollectionViewController {
  var viewModel: WatchlistViewModelProtocol! = WatchlistViewModel()
  
  private let cellType = WatchlistCell.self
  private var cellId: String { String(describing: cellType) }
}

// MARK: - Lifecycle

extension WatchlistController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setupCollectionView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    refresh()
    UIApplication.mainTabBarController()?.viewControllers?[1].tabBarItem.badgeValue = nil
  }
}

// MARK: - Setup

private extension WatchlistController {
  func setup() {
    setupCollectionView()
  }

  func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(
      cellType,
      forCellWithReuseIdentifier: cellId
    )

    // Added to delete a movie by using a UILongPressGestureRecognizer
    let gesture = UILongPressGestureRecognizer(
      target: self,
      action: #selector(collectionViewLongPressed)
    )
    collectionView?.addGestureRecognizer(gesture)
  }
}

// MARK: - Actions

private extension WatchlistController {
  @objc
  func collectionViewLongPressed(gesture: UILongPressGestureRecognizer) {
    let location = gesture.location(in: collectionView)

    guard let selectedIndexPath = collectionView?.indexPathForItem(at: location) else {
      return
    }

    print(selectedIndexPath.item)

    presentConfirmRemoveSheet(at: selectedIndexPath)
  }
}

// MARK: - Refresh

private extension WatchlistController {
  func refresh() {
    viewModel.refreshData()
    collectionView?.reloadData()
  }
}

// MARK: - Helpers

private extension WatchlistController {
  func presentConfirmRemoveSheet(at indexPath: IndexPath) {
    let alertController = UIAlertController(
      title: "Remove Movie?",
      message: nil,
      preferredStyle: .alert
    )

    let yes = UIAlertAction(
      title: "Yes",
      style: .destructive,
      handler: { _ in
        self.removeMovie(at: indexPath)
      }
    )
    alertController.addAction(yes)

    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(cancel)

    present(alertController, animated: true)
  }

  func removeMovie(at indexPath: IndexPath) {
    viewModel.removeItem(at: indexPath.row)
    collectionView?.deleteItems(at: [indexPath])
  }
  
  func showDetailsForMovie(at indexPath: IndexPath) {
    let detailsVM = viewModel.detailsVM(at: indexPath.row)
    
    let movieDetailsView = Bundle.main.loadNibNamed(
      "MovieDetailsView",
      owner: self,
      options: nil
    )?.first as! MovieDetailsView
    movieDetailsView.viewModel = detailsVM
    movieDetailsView.frame = view.frame
    movieDetailsView.onDismissTap = { [weak self] in
      guard let self = self else { return }
      self.refresh()
    }
    
    let window = UIApplication.shared.keyWindow
    window?.addSubview(movieDetailsView)
  }
}

// MARK: - UICollectionViewDataSource

extension WatchlistController {
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return viewModel.itemVMs.count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellId,
      for: indexPath
    ) as! WatchlistCell

    cell.viewModel = viewModel.itemVMs[indexPath.item]

    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension WatchlistController {
  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    showDetailsForMovie(at: indexPath)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WatchlistController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = (view.frame.width - 3 * 16) / 2

    return CGSize(width: width, height: width + 46)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 16
  }
}
