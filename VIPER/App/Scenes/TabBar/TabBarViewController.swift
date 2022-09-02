//
//  TabBarViewController.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//

import UIKit

typealias Tabs = (
    home: UIViewController,
    profile: UIViewController,
    search: UIViewController
)

class TabBarViewController: UITabBarController {
    init( tabs: Tabs ) {
        super.init(nibName: nil, bundle: nil)
        UITabBar.appearance().barTintColor      = .white
        UITabBar.appearance().backgroundColor   = .systemBackground
        UITabBar.appearance().isTranslucent     = false
        
        // SE CREA UN NAVIGATION CONTROLLER PARA CADA UIVIEWCONTROLLER
        let navSearch   = UINavigationController( rootViewController: tabs.search   )
        let navHome     = UINavigationController( rootViewController: tabs.home     )
        let navProfile  = UINavigationController( rootViewController: tabs.profile  )
        
        viewControllers = [
            navProfile  ,
            navHome     ,
            navSearch   ]
        
    }

    required init?( coder: NSCoder ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
    }
    
    //    private func colorNavController() {
    //        guard let items = tabBar.items else { return }
    //        for item in items {
    //            item.imageInsets    =  UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    //            let unselectedItem  = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
    //            let selectedItem    = [NSAttributedString.Key.foregroundColor: UIColor.systemGray3]
    //            item.setTitleTextAttributes(unselectedItem, for: .normal)
    //            item.setTitleTextAttributes(selectedItem, for: .selected)
    //        }
    //    }
    //
}
