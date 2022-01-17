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
        viewControllers = [tabs.home, tabs.profile]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
