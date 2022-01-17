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
        profile: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}



extension TabBarWireFrame {
    
    static func tabs(unsingSubmodules submodules: Submodules) -> Tabs {
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 11)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 12)
        
        submodules.home.tabBarItem = homeTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        
        return (
            home: submodules.home,
            profile: submodules.profile
        )
    }
}
