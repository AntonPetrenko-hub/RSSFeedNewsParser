//
//  NewsFeed.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 18/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import Foundation

class NewsFeed {
    var url: String
    var title: String
    
    init(url: String, title: String) {
        self.url = url
        self.title = title
    }
}

protocol RSSNewsFeed {
    
}
