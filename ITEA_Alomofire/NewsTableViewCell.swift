//
//  NewsTableViewCell.swift
//  ITEA_Alomofire
//
//  Created by Alex Marfutin on 8/8/19.
//  Copyright © 2019 G9. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var descriptionLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
