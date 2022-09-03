//
//  NewsViewController.swift
//  JanDanSwift
//
//  Created by huangyuan on 2022/8/23.
//

import UIKit
import Alamofire
import SnapKit
import MZRefresh
class NewsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var newsListView : UITableView!
    var newsList:[NewsItem] = []
    var currentPage = 1;

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "新鲜事"
        view.backgroundColor = .white
        self.newsListView = UITableView(frame: self.view.bounds)
        debugPrint("加载新鲜事")
        
        newsListView = UITableView(frame: view.bounds)
        newsListView.dataSource = self
        newsListView.delegate = self
        newsListView.setRefreshHeader(MZRefreshNormalHeader(beginRefresh: {
            self.loadNewsList(loadMore: false)
        }))
        newsListView.setRefreshFooter(MZRefreshNormalFooter(beginRefresh: {
            self.loadNewsList(loadMore: true)
        }))
        view.addSubview(newsListView)
        loadNewsList(loadMore: false)
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

    func loadNewsList(loadMore:Bool){
        if(loadMore){
            currentPage = currentPage+1
        }else{
            currentPage = 1
        }
        let url="https://i.jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=url,date,tags,author,title,excerpt,comment_count,comment_status,custom_fields&custom_fields=thumb_c,views&dev=1&page=" + String(currentPage)
       
        
     
        
        AF.request(url).responseString(completionHandler:  {(response) in
            if(loadMore){
                self.newsListView.stopFooterRefreshing()
            }else{
                self.newsListView.stopHeaderRefreshing()
            }
            switch response.result{
            case .success(let json):
                debugPrint("请求成功 responseString")
                self.showResponse(response:json,loadmore:  loadMore)

                break;
            case .failure(let error):
                debugPrint("请求失败 responseString")
                debugPrint("\(type(of: error))")
                debugPrint(error)
                break;
            }
        })
        
    }
    func showResponse(response:String, loadmore:Bool){
       
        if let json = response.data(using: .utf8){
            let newsListDetail  = try? JSONDecoder().decode(NewsListDetailModel.self, from: json);
            if(newsListDetail != nil){
                debugPrint("showResponse")
                let currentData = newsListDetail?.posts ?? []
                if(loadmore){
                    newsList.append(contentsOf: currentData)
                }else{
                    newsList = currentData
                }
               
                self.newsListView.reloadData()
            }

        }
        
        
    }

}
