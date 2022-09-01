//
//  AppDelegate.swift
//  JanDanSwift
//
//  Created by huangyuan on 2022/8/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let news = NewsViewController()
        news.tabBarItem.title = "新鲜事"
        
        let confide = ConfideViewController()
        confide.tabBarItem.title = "树洞"
        
        let boring = BoringViewController()
        boring.tabBarItem.title = "无聊图"
        
        let girls = GirlsViewController()
        girls.tabBarItem.title = "妹子图"
       
        let tabbarControll = UITabBarController()
        tabbarControll.tabBar.clipsToBounds = true
        tabbarControll.setViewControllers([news,confide,boring,girls], animated: true)
        
        let nav = UINavigationController(rootViewController: tabbarControll);
        nav.setNavigationBarHidden(true, animated: true)
    
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true;
    }
    
  

}

