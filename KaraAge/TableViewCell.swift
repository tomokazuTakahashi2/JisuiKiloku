//
//  TableViewCell.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/21.
//  Copyright © 2020 takahashi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var starButton1: UIButton!
    @IBOutlet weak var starButton2: UIButton!
    @IBOutlet weak var starButton3: UIButton!
    @IBOutlet weak var starButton4: UIButton!
    @IBOutlet weak var starButton5: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func setPostData(_ postData: Task) {
//
//        self.postImageView.image = postData.imageString
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        let dateString = formatter.string(from: postData.date!)
//        self.dateLabel.text = dateString
//
//        self.titleLabel.text = "\(postData.caption!)"
//    }
}
