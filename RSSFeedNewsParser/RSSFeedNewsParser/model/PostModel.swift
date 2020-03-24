//
//  PostModel.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 20/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    init(title: String, description: String, imageAddress: String, content: String, opened: Bool) {
        self.title = title
        self.description = description
        self.imageAddress = imageAddress
        self.content = content
        self.opened = opened
    }
    
    var title: String
    var description: String
    var imageAddress: String
    var content: String
    var opened: Bool = false
}
