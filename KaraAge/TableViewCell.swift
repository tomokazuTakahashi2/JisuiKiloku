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
    
    func setButton(_ task:Task){
        //星ボタン１
        if task.tapped1 == true {
            let starButtonON = UIImage(named: "星（色）")
            self.starButton1.setImage(starButtonON, for: .normal)
        } else {
            let starButtonOFF = UIImage(named: "星（モノクロ）")
            self.starButton1.setImage(starButtonOFF, for: .normal)
        }
        //星ボタン２
        if task.tapped2 == true {
            let starButtonON = UIImage(named: "星（色）")
            self.starButton2.setImage(starButtonON, for: .normal)
        } else {
            let starButtonOFF = UIImage(named: "星（モノクロ）")
            self.starButton2.setImage(starButtonOFF, for: .normal)
        }
        //星ボタン3
        if task.tapped3 == true {
            let starButtonON = UIImage(named: "星（色）")
            self.starButton3.setImage(starButtonON, for: .normal)
        } else {
            let starButtonOFF = UIImage(named: "星（モノクロ）")
            self.starButton3.setImage(starButtonOFF, for: .normal)
        }
        //星ボタン4
        if task.tapped4 == true {
            let starButtonON = UIImage(named: "星（色）")
            self.starButton4.setImage(starButtonON, for: .normal)
        } else {
            let starButtonOFF = UIImage(named: "星（モノクロ）")
            self.starButton4.setImage(starButtonOFF, for: .normal)
        }
        //星ボタン5
        if task.tapped5 == true {
            let starButtonON = UIImage(named: "星（色）")
            self.starButton5.setImage(starButtonON, for: .normal)
        } else {
            let starButtonOFF = UIImage(named: "星（モノクロ）")
            self.starButton5.setImage(starButtonOFF, for: .normal)
        }
    }
    

}
