//
//  NewsListTableViewController.swift
//  WxToutiao
//
//  Created by 王伟奇 on 2017/6/11.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    var parentNavi: UINavigationController?
    
    var newsList: [Post] = []
    
    var id = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Post.request(id: id) { (post) in
            if let posts = post {
                
                OperationQueue.main.addOperation {
                    //刷新数据
                    self.newsList = posts
                    self.tableView.reloadData()
                }
                
            } else {
                print("网络错误")
            }
        }
        
        //cell行高度自适应设置
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell
        
        let news = newsList[indexPath.row]
     
        
        cell.titleLabel.text = news.title
        
        
        cell.commentLabel.text = "评论： \(news.comment_count!)"

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let news = newsList[(tableView.indexPathForSelectedRow?.row)!]
        
        let detaileVC = storyboard?.instantiateViewController(withIdentifier: "NewsDetail") as! NewsDetail
        
        detaileVC.post = news
        
        //导航压入下一界面 push  运用了栈   parsent是直接跳到下一个界面
        parentNavi?.pushViewController(detaileVC, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
