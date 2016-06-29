//
//  ListViewController.swift
//  twitterApp
//
//  Created by 原田　礼朗 on 2016/06/30.
//  Copyright © 2016年 reo harada. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tweetTableView: UITableView!
    var data: [[String: AnyObject]] = []
    var refresh: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let xib = UINib(nibName: "TweetTableViewCell", bundle: nil)
        self.tweetTableView.registerNib(xib, forCellReuseIdentifier: "TweetTableViewCell")
        
        self.refresh = UIRefreshControl()
        self.refresh.addTarget(self, action: #selector(ListViewController.reload), forControlEvents: UIControlEvents.ValueChanged)
        self.tweetTableView.addSubview(self.refresh)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.reload()
    }
    
    func reload() {
        self.data = []
        let query = NCMBQuery(className: "tweet")
        query.orderByDescending("createDate")
        query.findObjectsInBackgroundWithBlock { (values, error) in
            if error == nil {
                values.forEach({ (val) in
                    let addData: [String: AnyObject] = [
                        "userName": val.objectForKey("userName"),
                        "tweet": val.objectForKey("tweet"),
                        "objectId": val.objectForKey("objectId"),
                        "createDate": val.createDate,
                        "profileImageURL": val.objectForKey("profileImageURL"),
                        "likeNumber": val.objectForKey("likeNumber"),
                    ]
                    self.data.append(addData)
                    print("データ追加")
                })
                self.tweetTableView.reloadData()
                self.refresh.endRefreshing()
            }
            else {
                print("サーバーエラー")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.data.count)
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        cell.userNameLabel.text = self.data[indexPath.row]["userName"] as? String
        cell.tweetTextView.text = self.data[indexPath.row]["tweet"] as? String
        let url = self.data[indexPath.row]["profileImageURL"] as? String
        let data = NSData(contentsOfURL: NSURL(string: url!)!)
        cell.profileImageView.image = UIImage(data: data!)
        cell.profileImageView.layer.masksToBounds = true
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = self.data[indexPath.row]["createDate"] as? NSDate
        cell.timeLabel.text = formatter.stringFromDate(date!)
        let likeNumber = self.data[indexPath.row]["likeNumber"] as? Int
        cell.likeNumber.text = "\(likeNumber!)"
        cell.objectId = self.data[indexPath.row]["objectId"] as! String
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell")
        return cell!.frame.size.height
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
