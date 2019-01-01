//
//  MainTabBarController.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 29/12/2018.
//  Copyright © 2018 joashtubaga. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    UINavigationBar.appearance().prefersLargeTitles = true
    
    tabBar.tintColor = .black
    
    setupViewControllers()
  }
  
  //MARK:- Setup Functions
  
  func setupViewControllers() {
    let layout = UICollectionViewFlowLayout()
    let watchlistController = WatchlistController(collectionViewLayout: layout)
    
    viewControllers = [
      generateNavigationController(for: MediasSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
      generateNavigationController(for: watchlistController, title: "Watchlist", image: #imageLiteral(resourceName: "favorites"))
//      generateNavigationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
    ]
  }
  
  //MARK:- Helper Functions
  
  fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    rootViewController.navigationItem.title = title
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    return navController
  }
  
}
