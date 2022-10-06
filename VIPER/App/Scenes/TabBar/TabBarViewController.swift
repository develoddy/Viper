import UIKit

typealias Tabs = (
    home: UIViewController,
    profile: UIViewController,
    search: UIViewController,
    bell: UIViewController,
    messages: UIViewController
)

class TabBarViewController: UITabBarController {
    
    init( tabs: Tabs ) {
        super.init(nibName: nil, bundle: nil)
        UITabBar.appearance().barTintColor      = .white
        UITabBar.appearance().backgroundColor   = .systemBackground
        UITabBar.appearance().isTranslucent     = false
        
        // SE CREA UN NAVIGATION CONTROLLER PARA CADA UIVIEWCONTROLLER
        /*let navSearch   = UINavigationController( rootViewController: tabs.search   )
        let navHome     = UINavigationController( rootViewController: tabs.home     )
        let navProfile  = UINavigationController( rootViewController: tabs.profile  )
        let navBell     = UINavigationController( rootViewController: tabs.bell     )
        let messages    = UINavigationController( rootViewController: tabs.messages )*/
        
        // HOME
        let buttonHomeIconSelected = UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let buttonHomeIconUnselected = UIImage(systemName: "house.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let navHome = generateNavController(vc: tabs.home, selected: buttonHomeIconSelected! , unselected: buttonHomeIconUnselected!)
        
        // PROFILE
        let buttonProfileIconSelected = UIImage(systemName: "person", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let buttonProfileIconUnselected = UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let navProfile = generateNavController(vc: tabs.profile, selected: buttonProfileIconSelected! , unselected: buttonProfileIconUnselected!)
        
        // SEARCH
        let buttonSearchIconSelected = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let buttonSearchIconUnselected = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let navSearch = generateNavController(vc: tabs.search, selected: buttonSearchIconSelected!, unselected: buttonSearchIconUnselected!)
        
        // NOTIFICATIONS
        let buttonBellIconSelected =
        UIImage(systemName: "bell", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let buttonBellIconUnselected =
        UIImage(systemName: "bell.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let navBell = generateNavController(vc: tabs.bell, selected: buttonBellIconSelected!, unselected: buttonBellIconUnselected!)
        
        // MENSAJES
        let buttonMessagesIconSelected = UIImage(systemName: "tray", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let buttonMessagesIconUnselected = UIImage(systemName: "tray.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let messages =  generateNavController(vc: tabs.messages, selected: buttonMessagesIconSelected!, unselected: buttonMessagesIconUnselected!)
        
        viewControllers = [
            navHome     ,
            navProfile  ,
            navSearch   ,
            navBell     ,
           messages
        ]
        colorNavController()
    }

    required init?( coder: NSCoder ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
    }
    
    fileprivate func generateNavController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let navController                       = UINavigationController(rootViewController: vc)
        navController.tabBarItem.image          = selected.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage  =  unselected.withRenderingMode(.alwaysOriginal)
        navController.title = title
        return  navController
    }
    
    private func colorNavController() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets    =  UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
            let unselectedItem  = [NSAttributedString.Key.foregroundColor: Constants.Color.secondary]
            let selectedItem    = [NSAttributedString.Key.foregroundColor: Constants.Color.secondary]
            item.setTitleTextAttributes(unselectedItem, for: .normal)
            item.setTitleTextAttributes(selectedItem, for: .selected)
        }
    }
}
