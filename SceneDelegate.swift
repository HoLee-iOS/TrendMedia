//
//  SceneDelegate.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        UserDefaults.standard.set(false, forKey: "First") //>> 다른 화면에 배치해야함
//        true이면 ViewController, false이면 SearchMovieTableViewController
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        //화면을 보여주게 해주는 코드
        window?.makeKeyAndVisible()
        
        if UserDefaults.standard.bool(forKey: "First") {

            //가장 첫번째로 뜰 루트뷰화면을 제작
            let sb = UIStoryboard(name: "Trend", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController

            window?.rootViewController = vc


        } else {

            //가장 첫번째로 뜰 루트뷰화면을 제작
            let sb = UIStoryboard(name: "Shopping", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ShoppingTableViewController") as! ShoppingTableViewController

            //아래와 같은 코드로 불러오면 네비게이션 컨트롤러 사용 가능함
            window?.rootViewController = UINavigationController(rootViewController: vc)

        }
        //화면을 보여주게 해주는 코드
        window?.makeKeyAndVisible()
        
        
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


}

