//
//  ViewController.swift
//  twitterApp
//
//  Created by 原田　礼朗 on 2016/06/29.
//  Copyright © 2016年 reo harada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSendTweetButton(sender: AnyObject) {
        let userName = "はらだれお"
        let tweet = self.tweetTextView.text
        let profileImageURL = "http://densetsunavi.com/wp-content/uploads/2015/01/2015-10-27_232442.png"
        let likeNumber = 0
        let obj = NCMBObject(className: "tweet")
        obj.setObject(userName, forKey: "userName")
        obj.setObject(tweet, forKey: "tweet")
        obj.setObject(profileImageURL, forKey: "profileImageURL")
        obj.setObject(likeNumber, forKey: "likeNumber")
        obj.saveInBackgroundWithBlock { (error) in
            if error == nil {
                print("データ投入成功")
                self.tweetTextView.text = ""
                self.tweetTextView.endEditing(true)
                self.navigationController?.popViewControllerAnimated(true)
            }
            else {
                print("データ挿入失敗")
            }
        }
    }

}

