//
//  MyNavigationViewController.swift
//  Caipu
//
//  Created by 李峰 on 16/8/6.
//  Copyright © 2016年 李峰. All rights reserved.
//

import UIKit

class MyNavigationViewController : ENSideMenuNavigationController,ENSideMenuDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuVC = MenuViewController()
        
        sideMenu = ENSideMenu(sourceView: menuVC.view, menuViewController: menuVC, menuPosition:.Left)
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 180.0 // optional, default is 160
        //sideMenu?.bouncingEnabled = false
        //sideMenu?.allowPanGesture = false
        // make navigation bar showing over side menu
        view.bringSubviewToFront(navigationBar)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
    
}
