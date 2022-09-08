//
//  BoringViewController.swift
//  JanDanSwift
//
//  Created by huangyuan on 2022/8/23.
//

import Alamofire
import SnapKit
import UIKit
import MJRefresh
class BoringViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var boringPictureListView: UITableView!
    var boringPictureList: [BoringPictureItem] = []
    var startId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "无聊图"
        view.backgroundColor = .white
        boringPictureListView = UITableView(frame: view.bounds)
        debugPrint("加载无聊图")

        boringPictureListView = UITableView(frame: view.bounds)
        boringPictureListView.dataSource = self
        boringPictureListView.delegate = self
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refresh))
        header.lastUpdatedTimeLabel?.isHidden = true
        boringPictureListView.mj_header = header
        
        view.addSubview(boringPictureListView)
        
        loadBoringPictureList(loadMore: false)
    }

    // 设置单元格数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boringPictureList.count
    }

    // 设置单元格内容

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 设置重用单元格名称
        let identifier = "reusedCell"
        // 使用重用单元格

        var cell: BoringCellTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? BoringCellTableViewCell

        // 如果单元格为nil创建重用单元格
        if cell == nil {
            cell = BoringCellTableViewCell(style: .default, reuseIdentifier: identifier)
        }

        cell?.setData(boringPictureItem: boringPictureList[indexPath.row])
        return cell!
    }

//    // 自定义单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = boringPictureList[indexPath.row].images[0].height
        return height + 120
    }

    // 点击单元格响应事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    @objc func refresh(){
        loadBoringPictureList(loadMore: false)
    }
    @objc func loadMore(){
        loadBoringPictureList(loadMore: true)
    }

    func loadBoringPictureList(loadMore: Bool) {
        if loadMore {
            startId = boringPictureList.last?.id ?? 0
        } else {
            startId = 0
        }
        let url = "https://api.jandan.net/api/v1/comment/list/26402"

        AF.request(url).responseString(completionHandler: { response in
            if loadMore {
                self.boringPictureListView.mj_footer?.endRefreshing()
            } else {
                self.boringPictureListView.mj_header?.endRefreshing()
            }
            switch response.result {
            case let .success(json):
                debugPrint("无聊图 请求成功 responseString")
                self.showResponse(response: json, loadmore: loadMore)

                break
            case let .failure(error):
                debugPrint("无聊图请求失败 responseString")
                debugPrint("\(type(of: error))")
                debugPrint(error)
                break
            }
        })
    }

    func showResponse(response: String, loadmore: Bool) {
        if let json = response.data(using: .utf8) {
            let boringPictureModel = try? JSONDecoder().decode(BoringPictureModel.self, from: json)
            if boringPictureModel != nil {
                debugPrint("showResponse")
                let currentData = boringPictureModel?.data ?? []
                
                if(boringPictureList.count==0){
                    let footer = MJRefreshAutoNormalFooter();
                    boringPictureListView.mj_footer = footer;
                    footer.setRefreshingTarget(self, refreshingAction: #selector(loadMore))
                }
                
                if loadmore {
                    boringPictureList.append(contentsOf: currentData)
                } else {
                    boringPictureList = currentData
                }
                boringPictureListView.reloadData()
            }
        }
    }
}
