//
//  ArticleBodyCell.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class ArticleBodyCell: UITableViewCell {
    
    private lazy var bodyLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
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
        contentView.addSubviews([bodyLabel])
        
        bodyLabel
            .edgeToSuperViewVerical(margin: 8)
            .edgeToSuperViewHorizontal(margin: 16)
    }
    
    func loadData(_ body: String?) {
        bodyLabel.text = body
    }
}

