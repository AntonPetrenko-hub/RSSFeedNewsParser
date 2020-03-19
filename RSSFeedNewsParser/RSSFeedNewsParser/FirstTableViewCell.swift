//
//  FirstTableViewCell.swift
//  RSSFeedNewsParser
//
//  Created by CloudWorks on 18/03/2020.
//  Copyright © 2020 CloudWorks. All rights reserved.
//

import UIKit

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
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ title: String, _ desc: String){
        nameLabel.text = title
        descriptionLabel.text = desc
        newsImage.image = UIImage(named: "bbcnews")
    }
    
}
