//
//  SettingsViewController.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 19/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var firstUrlLabel: UITextField!
    
    @IBOutlet weak var firstPageTitleLabel: UITextField!
    
    @IBOutlet weak var secondUrlLabel: UITextField!
    
    @IBOutlet weak var secondPageTitleLabel: UITextField!
    
    @IBOutlet weak var thirdUrlLabel: UITextField!
    
    @IBOutlet weak var thirdPageTitleLabel: UITextField!
    
    @IBOutlet weak var timerLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPress(_ sender: UIButton) {
        
        if firstUrlLabel.text == "" || firstPageTitleLabel.text == "" || secondUrlLabel.text == "" || secondPageTitleLabel.text == "" || thirdUrlLabel.text == "" || thirdPageTitleLabel.text == "" {
            let alert = UIAlertController(title: "Wrong content", message: "Please, fill all fields!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            UserDefaults.standard.set(URL(string: firstUrlLabel.text ?? ""), forKey: "FirstPageURL")
            UserDefaults.standard.set( firstPageTitleLabel.text ?? "", forKey: "FirstPageName")
            let one = UserDefaults.standard.url(forKey: "FirstPageURL")
            let two = UserDefaults.standard.string(forKey: "FirstPageName")
            print("URL: \(one) Name: \(two)")
        }
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
