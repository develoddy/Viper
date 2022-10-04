
import UIKit

class TabBarModuleBuilder {
    
    static func build(usingSubmodules submodules: TabBarWireFrame.Submodules) -> UITabBarController {
        
        let tabs = TabBarWireFrame.tabs(unsingSubmodules: submodules)
        let tabBarController = TabBarViewController(tabs: tabs)
        return tabBarController
    }
}
