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
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func configUI() {
        addSubviews([stackView])
        
        setTitleViewInStackView()
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(summaryLabel)
        
        stackView
            .edgeToSuperViewVerical(margin: 12)
            .edgeToSuperViewHorizontal(margin: 16)
    }
    
    private func setTitleViewInStackView() {
        
        let bodyTitleView = UIView()
        bodyTitleView.backgroundColor = .clear
        
        bodyTitleView.addSubviews([titleLabel, iconImage])
        
        stackView.addArrangedSubview(bodyTitleView)
        
        setupAnchors()
    }
    
    private func setupAnchors() {
        titleLabel
            .edgeToSuperViewVerical()
            .leadingToSuperview()
        
        iconImage
            .width(12)
            .height(12)
            .leadingToTrailing(of: titleLabel, margin: 8)
            .trailingToSuperview()
            .centerY(of: titleLabel)
    }
    
    func loadData(with article: ArticleListViewModel.ArticleViewModel?) {
        titleLabel.text = article?.title
        authorLabel.text = article?.author
        summaryLabel.text = article?.summary
    }
}
