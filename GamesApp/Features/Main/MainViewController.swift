//
//  MainViewController.swift
//  GamesApp
//
//  Created by Elgendy on 10.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(named: "tabbar-color")
        self.viewControllers = setupTabBarViewControllers()
    }
    
    func setupTabBarViewControllers() -> [UIViewController] {
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "games-icon"), tag: 0)
        
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let viewControllers = [searchViewController, favoriteViewController]
        return viewControllers.map { UINavigationController(rootViewController: $0) }
    }

}
