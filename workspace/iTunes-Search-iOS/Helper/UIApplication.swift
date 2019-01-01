//
//  UIApplication.swift
//  iTunes-Search-iOS
//
//  Created by Joash Tubaga on 02/01/2019.
//  Copyright © 2019 joashtubaga. All rights reserved.
//

import UIKit

extension UIApplication {
  static func mainTabBarController() -> MainTabBarController? {
    //UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
    
    return shared.keyWindow?.rootViewController as? MainTabBarController
  }
}

