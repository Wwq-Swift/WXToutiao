//
//  TextCell.swift
//  WxToutiao
//
//  Created by 王伟奇 on 2017/6/11.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
