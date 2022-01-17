//
//  TabBarModuleBuilder.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//

import UIKit

class TabBarModuleBuilder {
    
    static func build(usingSubmodules submodules: TabBarWireFrame.Submodules) -> UITabBarController {
        
        let tabs = TabBarWireFrame.tabs(unsingSubmodules: submodules)
        let tabBarController = TabBarViewController(tabs: tabs)
        return tabBarController
    }
}
