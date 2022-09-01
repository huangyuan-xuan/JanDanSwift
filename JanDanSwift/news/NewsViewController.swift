//
//  NewsViewController.swift
//  JanDanSwift
//
//  Created by huangyuan on 2022/8/23.
//

import UIKit
import Alamofire
import SnapKit
class NewsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var newsListView : UITableView!
    var newsList:[NewsItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "新鲜事"
        view.backgroundColor = .white
        self.newsListView = UITableView(frame: self.view.bounds)
        
        newsListView = UITableView(frame: view.bounds)
        newsListView.dataSource = self
        newsListView.delegate = self
        view.addSubview(newsListView)
        loadNewsList(page: 1)
    }
    
    
    //设置单元格数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    //设置单元格内容

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //设置重用单元格名称
        let identifier = "reusedCell"
        //使用重用单元格
        
        var cell:NewsCellTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? NewsCellTableViewCell
        
        
        //如果单元格为nil创建重用单元格
        if cell == nil{
            cell = NewsCellTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.setData(newsItem: newsList[indexPath.row])
        return cell!
    }
    //自定义单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //点击单元格响应时间
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

    func loadNewsList(page:Int){
        let url="https://i.jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=url,date,tags,author,title,excerpt,comment_count,comment_status,custom_fields&custom_fields=thumb_c,views&dev=1&page=" + String(page)
       
        
     
        
        AF.request(url).responseString(completionHandler:  {(response) in
            
            switch response.result{
            case .success(let json):
                debugPrint("请求成功 responseString")
                self.showResponse(response:json)

                break;
            case .failure(let error):
                debugPrint("请求失败 responseString")
                debugPrint("\(type(of: error))")
                debugPrint(error)
                break;
            }
        })
        
    }
    func showResponse(response:String){
       
        if let json = response.data(using: .utf8){
            let newsListDetail  = try? JSONDecoder().decode(NewsListDetailModel.self, from: json);
            if(newsListDetail != nil){
                debugPrint("showResponse")
                newsList = newsListDetail?.posts ?? []
                self.newsListView.reloadData()
            }

        }
        
        
    }

}
