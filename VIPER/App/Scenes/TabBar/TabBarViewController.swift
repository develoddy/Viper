//
//  TabBarViewController.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//

import UIKit

typealias Tabs = (
    home: UIViewController,
    profile: UIViewController
)

class TabBarViewController: UITabBarController {

    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().isTranslucent = false
        
        viewControllers = [tabs.profile, tabs.home]
        colorNavController()
    }
    
    private func colorNavController() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets    =  UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
            let unselectedItem  = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
            let selectedItem    = [NSAttributedString.Key.foregroundColor: Constants.Color.whiteLight]
            item.setTitleTextAttributes(unselectedItem, for: .normal)
            item.setTitleTextAttributes(selectedItem, for: .selected)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
