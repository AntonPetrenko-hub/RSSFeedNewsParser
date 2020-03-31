//
//  SecondTableViewController.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 24/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import UIKit
import SwiftSoup

class NewSecondTableViewController: NewsFeedController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
                 
         if super.tabWasVisitedFirst == false {
                   super.tabWasVisitedFirst = true
               } else if super.tabWasVisitedFirst == true {
                       if super.posts.count > 0 {
                         DispatchQueue.main.async {
                             self.tableView.reloadData()
                         }
                       } else {
                        updatePageContenAndTableUI()
            }
               }
         
         // MARK: Calling timer
         if let interval = super.updatingTimeInterval {
             if interval >= 0 {
                 timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updatePageContenAndTableUI), userInfo: nil, repeats: true)
             }
         }
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
     }
    
    override func updatePageContenAndTableUI() {
        
         // Parse new data and update tableView
                DispatchQueue.global(qos: .background).async {
                         if let pageUrl = UserDefaults.standard.url(forKey: "SecondPageURL") {
                             self.posts = []
                             self.parser = XMLParser(contentsOf: pageUrl)!
                             self.parser.delegate = self
                             self.parser.parse()
                         }
                    
                    if let encoded = try? JSONEncoder().encode(self.posts) {
                        UserDefaults.standard.set(encoded, forKey: "posts")
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tableView.refreshControl?.endRefreshing()
                    }
                }
    }
    
    @IBAction func updatingButtonWasTapped(_ sender: Any) {
        updatePageContenAndTableUI()
    }
    
    override func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parse error: \(parseError)")
        super.tableView.reloadData()
    }
    
    override func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        super.tmpElement = elementName
        if elementName == "item" {
            super.tmpPost = Post(title: "", description: "", imageAddress: "", content: "", opened: false)
        }
        if elementName == "media:content" {
            super.tmpPost?.imageAddress = attributeDict["url"] ?? ""
        }
        
    }
    
    override func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let post = super.tmpPost {
             posts.append(post)
            }
            super.tmpPost = nil
        }
    }
    
    override func parser(_ parser: XMLParser, foundCharacters string: String?) {
        if let post = super.tmpPost, let str = string {
            if super.tmpElement == "title" {
                super.tmpPost?.title = post.title+str
            } else if super.tmpElement == "description" {
                super.tmpPost?.description = post.description+str
            }
        }
    }
    
    
}
