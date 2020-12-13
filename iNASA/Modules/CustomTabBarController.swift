//
//  CustomTabBarController.swift
//  iNASA
//
//  Created by Андрей Останин on 09.12.2020.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupControllers()
    }
    
    private func setupStyle() {
        tabBar.barTintColor = .darkText
        tabBar.tintColor = .white
        tabBar.alpha = 1
    }
    
    private func setupControllers() {
        let searchNavController = generateNavigationController(root: SearchViewController(),
                                                               title: K.TabBar.mainTabName,
                                                               image: UIImage(named: K.Image.mainTab))
        
        let loadingsNavController = generateNavigationController(root: DownloadsViewController(),
                                                                 title: K.TabBar.downloadsTabName,
                                                                 image: UIImage(named: K.Image.downloads))
        
        viewControllers = [searchNavController, loadingsNavController]
    }
    
    private func generateNavigationController(root: UIViewController, title: String, image: UIImage?) -> UINavigationController{
        root.navigationItem.title = title
        let navController = UINavigationController(rootViewController: root)
        navController.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.backgroundColor = .black
        navController.navigationBar.tintColor = .white
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.prefersLargeTitles = false
        navController.view.backgroundColor = .black
        navController.navigationBar.barTintColor = .black
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        return navController
    }
    
}
