//
//  PostModel.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 20/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    init(title: String, description: String, link: String, content:String, imageAddress: String, opened: Bool) {
        self.title = title
        self.description = description
        self.link = link
        self.content = content
        self.imageAddress = imageAddress
        self.opened = opened
    }
    
    var title: String
    var description: String
    var link: String
    var content: String
    var imageAddress: String
    var opened: Bool = false
}
