//
//  SceneDelegate.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // MARK: VALIDAMOS SI EL USUARIO TIENE EL TOKEN O SI NO ESTÁ LOGUEADO
    // SI TIENE EL TOKEN ENTONCES MOSTRAMOS EL TABBARCONTROLLER
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        /*
        if let windowScene = scene as? UIWindowScene {
             let window = UIWindow(windowScene: windowScene)
             let vc = ViewController()
             window.rootViewController =  vc
             self.window = window
             window.makeKeyAndVisible()
         }*/
        
    
        // MARK: PROPERTIES
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let appDelegate = AppDelegate()
        let obj = appDelegate.loginSession
        let token = obj?.success

        // MARK: VALIDATIONS
        if token != nil {
            let submodules = (
                home: HomeWireFrame.createHomeModule(),
                profile: ProfileWireFrame.createProfileModule(id: 0, name: "", token: "", indexPath: []),
                search: SearchWireFrame.createSearchModule() )

            let window                  = UIWindow(windowScene: windowScene)
            let tabBarController        = TabBarModuleBuilder.build(usingSubmodules: submodules)
            window.rootViewController   =  tabBarController
            self.window                 = window
            window.makeKeyAndVisible()
        } else {
            let window                  = UIWindow(windowScene: windowScene)
            let loginViewController     = LoginWireFrame.createLoginModule()
            loginViewController.modalPresentationStyle = .fullScreen
            self.window                 = window
            window.makeKeyAndVisible()
            window.rootViewController   = loginViewController
        }
        
        
        
        // Otra Forma de verificar login con token
        //        guard let windowScene = (scene as? UIWindowScene) else { return }
        //        if AuthManager.share.isSignedIn {
        //            let submodules = (
        //                home: HomeWireFrame.createHomeModule(),
        //                profile: ProfileWireFrame.createProfileModule(email: "", name: "", token: ""),
        //                search: SearchWireFrame.createSearchModule() )
        //            let window                  = UIWindow(windowScene: windowScene)
        //            let tabBarController        = TabBarModuleBuilder.build(usingSubmodules: submodules)
        //            window.rootViewController   =  tabBarController
        //            self.window                 = window
        //            window.makeKeyAndVisible()
        //        } else {
        //            print("else no hay token SceneDelegate")
        //            let window                  = UIWindow(windowScene: windowScene)
        //            let loginViewController     = LoginWireFrame.createLoginModule()
        //            loginViewController.modalPresentationStyle = .fullScreen
        //            self.window                 = window
        //            window.makeKeyAndVisible()
        //            window.rootViewController   = loginViewController
        //        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
    //MARK: ROOT VIEWCONTROLLER
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        window.rootViewController =  vc
        self.window = window
        window.makeKeyAndVisible()
    }
}

