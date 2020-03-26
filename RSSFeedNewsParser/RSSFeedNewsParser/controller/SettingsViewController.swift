//
//  SettingsViewController.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 19/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var updatingTime: Double?
    
    var firstTableViewController: FirstTableViewController?
    
//    let vc = FirstTableViewController()
    
    @IBOutlet weak var firstUrlLabel: UITextField!
    
    @IBOutlet weak var firstPageTitleLabel: UITextField!
    
    @IBOutlet weak var secondUrlLabel: UITextField!
    
    @IBOutlet weak var secondPageTitleLabel: UITextField!
    
    @IBOutlet weak var thirdUrlLabel: UITextField!
    
    @IBOutlet weak var thirdPageTitleLabel: UITextField!
    
    @IBOutlet weak var timerLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstUrlLabel.text = UserDefaults.standard.url(forKey: "FirstPageURL")?.absoluteString
        firstPageTitleLabel.text = UserDefaults.standard.string(forKey: "FirstPageName")
        secondUrlLabel.text = UserDefaults.standard.url(forKey: "SecondPageURL")?.absoluteString
        secondPageTitleLabel.text = UserDefaults.standard.string(forKey: "SecondPageName")
        thirdUrlLabel.text = UserDefaults.standard.url(forKey: "ThirdPageURL")?.absoluteString
        thirdPageTitleLabel.text = UserDefaults.standard.string(forKey: "ThirdPageName")
    }
   
    
    @IBAction func saveButtonPress(_ sender: UIButton) {
        
        // Validation
        if firstUrlLabel.text == "" || firstPageTitleLabel.text == "" || secondUrlLabel.text == "" || secondPageTitleLabel.text == "" || thirdUrlLabel.text == "" || thirdPageTitleLabel.text == "" {
            
            let alert = UIAlertController(title: "Wrong content", message: "Please, fill all fields!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            // Saving names and URLs to user defaults
            UserDefaults.standard.set(URL(string: firstUrlLabel.text!), forKey: "FirstPageURL")
            UserDefaults.standard.set( firstPageTitleLabel.text ?? "", forKey: "FirstPageName")
            UserDefaults.standard.set(URL(string: secondUrlLabel.text ?? ""), forKey: "SecondPageURL")
            UserDefaults.standard.set( secondPageTitleLabel.text ?? "", forKey: "SecondPageName")
            UserDefaults.standard.set(URL(string: thirdUrlLabel.text ?? ""), forKey: "ThirdPageURL")
            UserDefaults.standard.set( thirdPageTitleLabel.text ?? "", forKey: "ThirdPageName")
            
            // Changing tab bar items names
            self.tabBarController?.tabBar.items?[0].title = UserDefaults.standard.string(forKey: "FirstPageName")
            self.tabBarController?.tabBar.items?[1].title = UserDefaults.standard.string(forKey: "SecondPageName")
            self.tabBarController?.tabBar.items?[2].title = UserDefaults.standard.string(forKey: "ThirdPageName")
            
            
        }
        
        if timerLabel.text != "" {
            if let stringTime = Double(timerLabel.text!){
                
                let firstNVVC = self.tabBarController?.viewControllers![0] as! UINavigationController
                let firstVC = firstNVVC.viewControllers[0] as! FirstTableViewController
                firstVC.updatingTimeInterval = stringTime
                
                let secondNVVC = self.tabBarController?.viewControllers![1] as! UINavigationController
                let secondVC = secondNVVC.viewControllers[0] as! NewSecondTableViewController
                secondVC.updatingTimeInterval = stringTime
                
                let thirdNVVC = self.tabBarController?.viewControllers![2] as! UINavigationController
                let thirdVC = thirdNVVC.viewControllers[0] as! NewThirdViewController
                thirdVC.updatingTimeInterval = stringTime
                
//                NotificationCenter.default.post(name: .newTime, object: nil, userInfo: ["time":stringTime])
            }
            

        }
    }

}
