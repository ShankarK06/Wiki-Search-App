//
//  SA_SearchTableViewCell.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import UIKit

class SA_SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.cornerRadius = 10.0
        self.containerView.clipsToBounds = true
        self.avatarImage.layer.cornerRadius = 6.0
        self.avatarImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
