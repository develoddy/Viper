//
//  TabBarWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//

import UIKit

class TabBarWireFrame {
    
    var viewController : UIViewController
    
    typealias Submodules = (
        home: UIViewController,
        profile: UIViewController,
        search: UIViewController
    )
    
    init( viewController: UIViewController ) {
        self.viewController = viewController
    }
}

extension TabBarWireFrame {
    static func tabs(unsingSubmodules submodules: Submodules) -> Tabs {
        let homeTabBarItem      = UITabBarItem(
            title: "Inicio",
            image: UIImage(systemName: "house"),
            tag: 11)
        let profileTabBarItem   = UITabBarItem(
            title: "Perfil",
            image: UIImage(systemName: "person"),
            tag: 12)
        let searchTabBarItem    = UITabBarItem(
            title: "Buscar",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 12)
        
        submodules.home.tabBarItem      = homeTabBarItem
        submodules.profile.tabBarItem   = profileTabBarItem
        submodules.search.tabBarItem    = searchTabBarItem
        
        return (
            home: submodules.home,
            profile: submodules.profile,
            search: submodules.search
        )
    }
}
