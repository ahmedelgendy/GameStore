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
        tabBar.tintColor = R.color.tabbarColor()
        self.viewControllers = setupTabBarViewControllers()
    }
    
    func setupTabBarViewControllers() -> [UIViewController] {
        let gameService = GamesService(network: Networking())
        let searchViewModel = SearchViewModel(repository: GameRepository(service: gameService))
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        searchViewController.tabBarItem = UITabBarItem(title: "Games",
                                                       image: R.image.gamesIcon(),
                                                       tag: 0)
        
        let favoriteViewModel = FavoriteViewModel(repository: FavoriteRepository())
        let favoriteViewController = FavoriteViewController(viewModel: favoriteViewModel)
        favoriteViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let viewControllers = [searchViewController, favoriteViewController]
        return viewControllers.map { UINavigationController(rootViewController: $0) }
    }

}
