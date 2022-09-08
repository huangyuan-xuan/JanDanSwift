//
//  BoringCellTableViewCell.swift
//  JanDanSwift
//
//  Created by huangyuan on 2022/9/3.
//

import UIKit
import Kingfisher
import CoreAudio
import SwiftUI

class BoringCellTableViewCell: UITableViewCell {

    var _authorLabel: UILabel!
    var _timeLabel: UILabel!
    var _contentLabel: UILabel!
    var _positiveVoteLabel: UILabel!
    var _negativeVoteLabel: UILabel!
    var _commentCountLabel :UILabel!
    var _moreFunctionImageView:UIImageView!
    var _contentImageView:UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = true
        
            _authorLabel = UILabel()
            _authorLabel.adjustsFontSizeToFitWidth = true
            _authorLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(_authorLabel)
    
            _timeLabel = UILabel()
            _timeLabel.adjustsFontSizeToFitWidth = true
            _timeLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(_timeLabel)
       
            _contentLabel  = UILabel()
            _contentLabel.adjustsFontSizeToFitWidth = true;
            _contentLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(_contentLabel)
        
            _contentImageView  = UIImageView(frame: CGRect.zero)
            _contentImageView.translatesAutoresizingMaskIntoConstraints = false
            _contentImageView.contentMode = .scaleAspectFit
            contentView.addSubview(_contentImageView)
        
            _positiveVoteLabel  = UILabel()
            _positiveVoteLabel.adjustsFontSizeToFitWidth = true
            _positiveVoteLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(_positiveVoteLabel)

            _negativeVoteLabel  = UILabel()
            _negativeVoteLabel.adjustsFontSizeToFitWidth = true
            _negativeVoteLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(_negativeVoteLabel)

            _commentCountLabel  =  UILabel()
            _commentCountLabel.adjustsFontSizeToFitWidth = true
            _commentCountLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(_commentCountLabel)

            _moreFunctionImageView  = UIImageView(image: UIImage(named: "icDotsHorizontal"))
            _moreFunctionImageView.translatesAutoresizingMaskIntoConstraints = false;
            _moreFunctionImageView.contentMode = .scaleAspectFit
            contentView.addSubview(_moreFunctionImageView)
        
        
        
        _authorLabel.snp.makeConstraints{(make)->Void in
            make.top.equalTo(self.contentView.snp.top).offset(8);
            make.left.equalTo(self.contentView.snp.left).offset(8);
            make.width.equalTo(self.contentView)
        }
        _timeLabel.snp.makeConstraints{(make)->Void in
            make.top.equalTo(_authorLabel.snp.bottom).offset(8);
            make.left.equalTo(self.contentView.snp.left).offset(8)
            make.right.equalTo(self.contentView.snp.right).offset(8);
            make.width.equalTo(self.contentView);
        }

        _contentLabel.snp.makeConstraints{(make)->Void in
            make.top.equalTo(_timeLabel.snp.bottom).offset(8);
            make.left.equalTo(self.contentView.snp.left).offset(8)
            make.right.equalTo(self.contentView.snp.right).offset(8);
            make.width.equalTo(self.contentView);

        }

        _contentImageView.snp.makeConstraints{(make)->Void in
            make.top.equalTo(_contentLabel.snp.bottom);
            make.centerX.equalTo(self.contentView.snp.centerX)

        }

        let screenWidht = UIScreen.main.bounds.width
        let perFunctionWidth = screenWidht / 4;


        _positiveVoteLabel.snp.makeConstraints{(make)->Void in
            make.left.equalTo(self.contentView.snp.left)
            make.top.equalTo(_contentImageView.snp.bottom).offset(8)
            make.width.equalTo(perFunctionWidth)
        }

        _negativeVoteLabel.snp.makeConstraints{(make)->Void in
            make.left.equalTo(self._positiveVoteLabel.snp.right)
            make.top.equalTo(_contentImageView.snp.bottom).offset(8)
            make.width.equalTo(perFunctionWidth)
        }

        _commentCountLabel.snp.makeConstraints{(make)->Void in
            make.left.equalTo(self._negativeVoteLabel.snp.right)
            make.top.equalTo(_contentImageView.snp.bottom).offset(8)
            make.width.equalTo(perFunctionWidth)
        }
        _moreFunctionImageView.snp.makeConstraints{(make)->Void in
            make.left.equalTo(self._commentCountLabel.snp.right)
            make.top.equalTo(_contentImageView.snp.bottom).offset(8)
            make.width.equalTo(perFunctionWidth)
        }
       
           
            
        
    }

    func setData(boringPictureItem: BoringPictureItem) {

        _authorLabel.text = boringPictureItem.author;
        _timeLabel.text  = boringPictureItem.date

        _contentLabel.text = boringPictureItem.content
        _contentImageView.kf.setImage(with: URL(string: boringPictureItem.images[0].url) )
        
        _contentImageView.kf.indicatorType = .activity
        
        
        _positiveVoteLabel.text = String(format: "OO %d", boringPictureItem.vote_positive)
        _negativeVoteLabel.text = String(format: "XX %d", boringPictureItem.vote_negative)
        _commentCountLabel.text =  String(format: "吐槽 %d", boringPictureItem.sub_comment_count)
        
        
        _contentImageView.snp.remakeConstraints{(make) in
            make.top.equalTo(_contentLabel.snp.bottom);
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.equalTo(boringPictureItem.images[0].width)
            make.height.equalTo(boringPictureItem.images[0].height)
            
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
