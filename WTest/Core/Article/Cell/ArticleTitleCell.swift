//
//  ArticleTitleCell.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class ArticleTitleCell: UITableViewCell {
        
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var avatarImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.transforToCircle()
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var publishedTimeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func configUI() {
        contentView.addSubviews([avatarImage, titleLabel, authorLabel, publishedTimeLabel])
        
        backgroundColor = .white
        
        avatarImage
            .topToSuperview(margin: 8)
            .leadingToSuperview(margin: 16)
            .width(50)
            .height(50)
        
        avatarImage.layoutIfNeeded()
        
        titleLabel
            .topToSuperview(margin: 8)
            .leadingToTrailing(of: avatarImage, margin: 8)
        
        authorLabel
            .topToBottom(of: titleLabel, margin: 8)
            .leadingToTrailing(of: avatarImage, margin: 8)
            .bottomToSuperview(margin: 8)
        
        publishedTimeLabel
            .leadingToTrailing(of: authorLabel, margin: 8)
            .centerY(of: authorLabel)
            .trailingToSuperview(margin: 16)
    }
    
    func loadData(_ article: ArticleViewModel?) {
        avatarImage.loadImageWith(urlPath: article?.avatar,
                                  placeholderImage: UIImage(systemName: "person.circle.fill"),
                                  loadCacheEnabled: true, completion: nil)
        titleLabel.text = article?.title
        authorLabel.text = article?.author
        publishedTimeLabel.text = article?.publishedAt
    }
}
