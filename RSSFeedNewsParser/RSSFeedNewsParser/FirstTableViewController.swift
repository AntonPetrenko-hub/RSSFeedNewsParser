//
//  FirstTableViewController.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 18/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import UIKit

struct Post {
    var title: String
    var description: String
    var link: String
    var content: String
}

class FirstTableViewController: UITableViewController, XMLParserDelegate {
    
    var posts: [Post] = []
    
    var parser = XMLParser()
    var tmpPost: Post? = nil
    var tmpElement: String?
    
    var firstPageURL: URL?
    var firstPageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "FirstTableViewCell", bundle: .main)
        tableView.register(nibName, forCellReuseIdentifier: "Cell")
        
//        parser = XMLParser(contentsOf: URL(string: "https://www.npr.org/rss/rss.php?id=1001")!)!
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        firstPageURL = UserDefaults.standard.url(forKey: "FirstPageURL")
        firstPageName = UserDefaults.standard.string(forKey: "FirstPageName")
        
        print("URL: \(firstPageURL) Name: \(firstPageName)")
        
        
        
        DispatchQueue.global(qos: .background).async {
            if let pageUrl = self.firstPageURL {
                self.parser = XMLParser(contentsOf: pageUrl)!
                self.parser.delegate = self
                self.parser.parse()
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
	
    // MARK: - Parse delegate
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parse error: \(parseError)")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tmpElement = elementName
        if elementName == "item" {
            tmpPost = Post(title: "", description: "", link: "", content: "")
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
                   if let post = tmpPost {
                       posts.append(post)
                   }
                   tmpPost = nil
               }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String?) {
        if let post = tmpPost, let str = string {
            if tmpElement == "title" {
                tmpPost?.title = post.title+str
            } else if tmpElement == "link" {
                tmpPost?.link = post.link+str
            } else if tmpElement == "description" {
                tmpPost?.description = post.description+str
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FirstTableViewCell
//        cell.nameLabel.text = posts[indexPath.row].title
        cell.commonInit(posts[indexPath.row].title, posts[indexPath.row].description)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(posts[indexPath.row].link)
    }
    
}
