//
//  MainTabBarController.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 19/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items?[0].title = UserDefaults.standard.string(forKey: "FirstPageName")
        self.tabBar.items?[1].title = UserDefaults.standard.string(forKey: "SecondPageName")
        self.tabBar.items?[2].title = UserDefaults.standard.string(forKey: "ThirdPageName")

        // Do any additional setup after loading the view.
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
