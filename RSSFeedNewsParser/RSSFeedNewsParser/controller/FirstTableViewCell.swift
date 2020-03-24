//
//  FirstTableViewCell.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 18/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import UIKit
import SDWebImage

class FirstTableViewCell: UITableViewCell {

    var newsTitle: String?
    var newsDescription: String?
    var newsLink: String?
    var newsContent: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = newsTitle
        descriptionLabel.text = newsDescription
    }
    
    func commonInit(_ title: String, _ desc: String, _ img: String){
        nameLabel.text = title
        descriptionLabel.text = desc
        newsImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "loading"), completed: nil)
        
    }
    
}
