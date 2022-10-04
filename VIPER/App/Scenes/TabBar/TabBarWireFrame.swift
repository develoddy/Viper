import UIKit

class TabBarWireFrame {
    
    var viewController : UIViewController
    
    typealias Submodules = (
        home: UIViewController,
        profile: UIViewController,
        search: UIViewController,
        bell: UIViewController,
        messages: UIViewController
    )
    
    init( viewController: UIViewController ) {
        self.viewController = viewController
    }
}

extension TabBarWireFrame {
    static func tabs(unsingSubmodules submodules: Submodules) -> Tabs {
        
        let buttonHomeIcon = UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let homeTabBarItem = UITabBarItem(title: "Inicio", image: buttonHomeIcon, tag: 11)
        
        let buttonProfileIcon = UIImage(systemName: "person", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let profileTabBarItem = UITabBarItem(title: "Perfil", image: buttonProfileIcon, tag: 12)
        
        let buttonSearchIcon = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let searchTabBarItem = UITabBarItem(title: "Buscar", image: buttonSearchIcon, tag: 12)
        
        let buttonBellIcon = UIImage(systemName: "bell", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let bellTabBarItem = UITabBarItem(title: "Notificaciones", image: buttonBellIcon, tag: 12)
        
        let buttonMessagesIcon = UIImage(systemName: "tray", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))?.withTintColor(Constants.Color.secondary, renderingMode: .alwaysOriginal)
        let messagesTabBarItem = UITabBarItem(title: "Mensajes", image: buttonMessagesIcon, tag: 12)
        
        submodules.home.tabBarItem = homeTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        submodules.search.tabBarItem = searchTabBarItem
        submodules.bell.tabBarItem = bellTabBarItem
        submodules.messages.tabBarItem = messagesTabBarItem
        
        return (home: submodules.home,
                profile: submodules.profile,
                search: submodules.search,
                bell: submodules.bell,
                messages: submodules.messages
        )
    }
}
