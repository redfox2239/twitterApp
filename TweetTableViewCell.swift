//
//  TweetTableViewCell.swift
//  twitterApp
//
//  Created by 原田　礼朗 on 2016/06/30.
//  Copyright © 2016年 reo harada. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var objectId: String!
    @IBOutlet weak var likeNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapLikeButton(sender: AnyObject) {
        let likeNum = Int(self.likeNumber.text!)! + 1
        self.likeNumber.text = "\(likeNum)"
        let obj = NCMBObject(className: "tweet")
        obj.objectId = self.objectId
        obj.setObject(likeNum, forKey: "likeNumber")
        UIView.animateWithDuration(0.2, animations: {
            self.contentView.transform = CGAffineTransformMakeScale(2.0, 2.0)
            }) { (animate) in
                self.contentView.transform = CGAffineTransformIdentity
                obj.saveInBackgroundWithBlock { (error) in
                    if error == nil {
                        print("成功")
                    }
                    else {
                        print("失敗")
                    }
                }
        }
    }
    
}
