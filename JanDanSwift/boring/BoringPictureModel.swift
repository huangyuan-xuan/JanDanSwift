//
//  BoringPictureModel.swift
//  JanDanSwift
//
//  Created by huangyuan on 2022/9/3.
//

import UIKit


struct BoringPictureModel: Codable {
    var code:Int
    var msg:String
    var data: [BoringPictureItem]
}

struct BoringPictureItem:Encodable{
    var id:Int
    var author:String
    var date:String
    var content:String
    var vote_positive:Int
    var vote_negative:Int
    var sub_comment_count:Int
    var images:[BoringPictureImage]
    
}
extension BoringPictureItem: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        date = try container.decode(String.self, forKey: .date)
        content = try container.decode(String.self, forKey: .content)
        vote_positive = try container.decode(Int.self, forKey: .vote_positive)
        vote_negative = try container.decode(Int.self, forKey: .vote_negative)
        if(container.contains(.sub_comment_count)){
            sub_comment_count = try container.decode(Int.self, forKey: .sub_comment_count)
        }else{
            sub_comment_count = 0
           
        }
        images = try container.decode([BoringPictureImage].self, forKey: .images)
    }
}
struct BoringPictureImage:Encodable{
    var url:String
    var full_url:String
    var width:CGFloat  = 0
    var height:CGFloat = 0
    var rowWidth:CGFloat = 0
    var rowHeight:CGFloat = 0
   
}
extension BoringPictureImage:Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        full_url = try container.decode(String.self, forKey: .full_url)
        let imageSource = CGImageSourceCreateWithURL(URL(string: url)! as CFURL, nil)
        if let result = CGImageSourceCopyPropertiesAtIndex(imageSource!, 0, nil) as? Dictionary<String, Any> {
            
            if let widthPix = result["PixelWidth"] as? CGFloat, let heightPix = result["PixelHeight"] as? CGFloat {
                width = UIScreen.main.bounds.width - CGFloat(20)
                height = heightPix * width / widthPix;
                rowWidth = widthPix
                rowHeight = heightPix
                
                
            }
        }
        
    }
}


