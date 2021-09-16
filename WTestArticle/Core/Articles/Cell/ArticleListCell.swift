//
//  ArticleListCell.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class ArticleListCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var publishedTimeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stackView.arrangedSubviews.forEach({
            $0.removeFromSuperview()
        })
        stackView.removeFromSuperview()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func configUI() {
        contentView.addSubviews([stackView])
        
        setTitleViewInStackView()
        stackView.addArrangedSubview(authorLabel)
        
        stackView
            .edgeToSuperViewVerical(margin: 12)
            .edgeToSuperViewHorizontal(margin: 16)
        
        stackView.layoutIfNeeded()
    }
    
    private func setTitleViewInStackView() {
        
        let bodyTitleView = UIView()
        bodyTitleView.backgroundColor = .clear
        
        bodyTitleView.addSubviews([titleLabel, publishedTimeLabel, iconImage])
        
        stackView.addArrangedSubview(bodyTitleView)
        
        setupAnchors()
    }
  
    private func setupAnchors() {
        titleLabel
            .edgeToSuperViewVerical()
            .leadingToSuperview()
            .width(UIScreen.main.bounds.width * 0.5)
        
        publishedTimeLabel
            .centerY(of: titleLabel)
            .leadingToTrailing(of: titleLabel, margin: 8)
        
        iconImage
            .width(12)
            .height(12)
            .leadingToTrailing(of: publishedTimeLabel, margin: 8)
            .trailingToSuperview()
            .centerY(of: titleLabel)
    }
    
    private func setSummaryInStackView(_ summary: String?) {
        guard let summary = summary, !summary.isEmpty else {
            return
        }
        
        summaryLabel.text = summary
        
        stackView.addArrangedSubview(summaryLabel)
    }
    
    func loadData(with article: NewArticleListViewModel.NewArticleViewModel?) {
        titleLabel.text = article?.title
        authorLabel.text = article?.author
        publishedTimeLabel.text = article?.publishedAt
        setSummaryInStackView(article?.summary)
    }
}
