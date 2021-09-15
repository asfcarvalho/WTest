//
//  ZipCodeCell.swift
//  WTest
//
//  Created by Anderson F Carvalho on 14/09/21.
//

import UIKit

class ZipCodeCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var zipCodeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    private lazy var desigPostalLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
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
    }
    
    private func configUI() {
        contentView.addSubviews([stackView])
        
        stackView
            .edgeToSuperViewVerical(margin: 8)
            .edgeToSuperViewHorizontal(margin: 16)
        
        zipCodeLabel.width(90)
            
        stackView.addArrangedSubview(zipCodeLabel)
        stackView.addArrangedSubview(desigPostalLabel)
    }

    func loadData(zipCode: ZipCodeListViewModel.ZipCodeViewModel?) {
        zipCodeLabel.text = zipCode?.zipCode
        desigPostalLabel.text = zipCode?.desigPostal
    }
}
