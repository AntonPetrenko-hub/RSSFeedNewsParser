//
//  SecondTableViewController.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 24/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import UIKit
import SwiftSoup

class SecondTableViewController: UITableViewController {
    
     var tabWasVisitedFirst = false
     var posts: [Post] = []
     var updatingTimeInterval: Double?
     var tmpPost: Post?
     var tmpElement: String?
     
     var timer = Timer()
     var parser = XMLParser()
    
     override func viewDidLoad() {
         super.viewDidLoad()
         
         //Config TableView Cell
         let nibName = UINib(nibName: "FirstTableViewCell", bundle: .main)
         tableView.register(nibName, forCellReuseIdentifier: "Cell")
    }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
                 
         if tabWasVisitedFirst == false {
                   self.tabWasVisitedFirst = true
               } else if tabWasVisitedFirst == true {
                       if posts.count > 0 {
                         DispatchQueue.main.async {
                             self.tableView.reloadData()
                         }
                       } else {
                        updatePageContenAndTableUI()
            }
               }
         
         // MARK: Calling timer
         if let interval = updatingTimeInterval {
             if interval >= 0 {
                 timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updatePageContenAndTableUI), userInfo: nil, repeats: true)
             }
         }
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         timer.invalidate()
     }
     
    
    @IBAction func updateContentButtonPress(_ sender: Any) {
        updatePageContenAndTableUI()
    }
    
     @objc func updatePageContenAndTableUI() {
         
         // Change tab bar name
         self.tabBarController?.tabBar.items?[1].title = UserDefaults.standard.string(forKey: "SecondPageName")
         
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
             }
         }
     }
     
     func getPostsFromUserDefaults() {
           
           DispatchQueue.global(qos: .userInitiated).async {
               
               if let savedPosts = UserDefaults.standard.object(forKey: "posts") as? Data {
                   if let loadedPosts = try? JSONDecoder().decode([Post].self, from: savedPosts) {
                       self.posts = loadedPosts
                   }
               }
           }
       }
    
    // MARK: - Table view data source

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if posts[indexPath.row].opened == true {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FirstTableViewCell
                cell.commonInit(posts[indexPath.row].title, posts[indexPath.row].description, posts[indexPath.row].imageAddress)
                cell.nameLabel.numberOfLines = 2
                cell.descriptionLabel.numberOfLines = 2
                
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FirstTableViewCell
            cell.commonInit(posts[indexPath.row].title, posts[indexPath.row].description, posts[indexPath.row].imageAddress)
            cell.nameLabel.numberOfLines = 1
            cell.descriptionLabel.numberOfLines = 1
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if posts[indexPath.row].opened == false {
                posts[indexPath.row].opened = true
            } else if posts[indexPath.row].opened == true {
                posts[indexPath.row].opened = false
            }
            
            DispatchQueue.main.async {
                        tableView.reloadData()
            }
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if posts[indexPath.row].opened == true {
                if posts[indexPath.row].title.heightWithConstrainedWidth(width: 221.0, font: UIFont.systemFont(ofSize: 17.0)) + posts[indexPath.row].description.heightWithConstrainedWidth(width: 221.0, font: UIFont.systemFont(ofSize: 13.0) ) + 42.0 > 120.0 {
                    return CGFloat(120.0)
                }
            }
            return CGFloat(86.0)
        }
        
        // MARK: - Set timer
        
        @objc func setTime(notification: Notification) {
            print("Got it")
            if let newTimeIntervalFromDictionary = notification.userInfo {
                let newOptionalTimeInterval = newTimeIntervalFromDictionary["time"]
                if let timeDouble = newOptionalTimeInterval {
                    updatingTimeInterval = timeDouble as? Double
                }
            }
        }
        
        @IBAction func updateButtonClick(_ sender: UIBarButtonItem) {
            
            updatePageContenAndTableUI()
        }
}
        

//    extension Notification.Name {
//        static let newTime = Notification.Name("newTime")
//    }

    extension SecondTableViewController: XMLParserDelegate {
        
        // MARK: - XMLParse delegate
        
        func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
            print("Parse error: \(parseError)")
            self.tableView.reloadData()
        }
        
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            tmpElement = elementName
            if elementName == "item" {
                tmpPost = Post(title: "", description: "", imageAddress: "", content: "", opened: false)
            }
            if elementName == "media:content" {
                tmpPost?.imageAddress = attributeDict["url"] ?? ""
            }
        }
        
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if elementName == "item" {
                       if let post = tmpPost {
                        self.posts.append(post)
                       }
                       tmpPost = nil
                   }
        }
        
        func parser(_ parser: XMLParser, foundCharacters string: String?) {
            if let post = tmpPost, let str = string {
                if tmpElement == "title" {
                    tmpPost?.title = post.title+str
                } else if tmpElement == "description" {
                    tmpPost?.description = post.description+str
                }
            }
        }
    }
