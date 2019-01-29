//
//  TweetCell.swift
//  Twitter
//
//  Created by 이승헌 on 28/01/2019.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var tweet_content_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
