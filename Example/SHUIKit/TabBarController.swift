//
//  TabBarController.swift
//  SHUIKit_Example
//
//  Created by duarlen on 2021/9/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    private lazy var homeNav: UINavigationController = {
        let nav = UINavigationController(rootViewController: HomeController())
        nav.tabBarItem.title = "首页"
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [homeNav]
    }
}
