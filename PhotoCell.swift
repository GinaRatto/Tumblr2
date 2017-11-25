//
//  PhotoCell.swift
//  Tumblr_Feed
//
//  Created by Jungyoon Yu on 11/11/17.
//  Copyright © 2017 Jungyoon Yu. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
