//
//  NewsCellTableViewCell.swift
//  JanDanSwift
//
//  Created by huangyuan on 2022/9/1.
//

import UIKit
import Kingfisher
import CoreAudio

class NewsCellTableViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var converImageView: UIImageView!
    var authorNameLabel: UILabel!
    var timeLabel: UILabel!
    var commentLabel: UILabel!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        titleLabel.lineBreakMode=NSLineBreakMode.byTruncatingTail
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)

        converImageView = UIImageView(frame: CGRect.zero)
        converImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(converImageView)

        authorNameLabel = UILabel()
        authorNameLabel.adjustsFontSizeToFitWidth = true
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        authorNameLabel.textColor = .gray
        contentView.addSubview(authorNameLabel)

        timeLabel = UILabel()
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        timeLabel.textColor = .gray
        contentView.addSubview(timeLabel)

        commentLabel = UILabel()
        commentLabel.adjustsFontSizeToFitWidth = true
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        commentLabel.textColor = .gray
        contentView.addSubview(commentLabel)
    }

    func setData(newsItem: NewsItem) {
        let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        let date = dateFormatter.date(from: newsItem.date)
        dateFormatter.dateFormat = "MM-dd"
            let dateStr = dateFormatter.string(from: date ?? Date())
        self.timeLabel.text = dateStr
        self.titleLabel.text = newsItem.title;
        self.authorNameLabel.text = newsItem.author.name;
      
        self.commentLabel.text = String(format: "%d评论", arguments: [newsItem.comment_count])
        
        let imageUrl  = newsItem.custom_fields.thumb_c[0]
        self.converImageView.backgroundColor = .orange
        let url = URL(string: imageUrl)
                
        self.converImageView.kf.setImage(with: url )

        converImageView.snp.makeConstraints{(make)->Void in
            
            make.width.equalTo(120)
            make.height.equalTo(80)
            make.right.equalTo(contentView).offset(-10)
            make.centerY.equalTo(contentView.snp.centerY)
            
        }
        titleLabel.snp.makeConstraints{  (make)->Void in
            make.top.equalTo(contentView.snp.top).offset(10);
            make.left.equalTo(contentView.snp.left).offset(10);
            make.right.equalTo(converImageView.snp.left).offset(-10);
        }




        authorNameLabel.snp.makeConstraints{  (make)->Void in
            make.left.equalTo(contentView.snp.left).offset(10);
            make.bottom.equalTo(converImageView.snp.bottom);
        }
        timeLabel.snp.makeConstraints{  (make)->Void in
            make.left.equalTo(authorNameLabel.snp.right).offset(10);
            make.bottom.equalTo(authorNameLabel.snp.bottom);
        }
        commentLabel.snp.makeConstraints{  (make)->Void in
            make.right.equalTo(converImageView.snp.left).offset(-10);
            make.bottom.equalTo(converImageView.snp.bottom);
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
}
