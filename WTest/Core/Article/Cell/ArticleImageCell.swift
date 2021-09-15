//
//  ArticleImageCell.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class ArticleImageCell: UITableViewHeaderFooterView {
    
    var scrollView: UIScrollView?
    private var cachedMinimumSize: CGSize?
    
    private lazy var heroImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

    private func configUI() {
        contentView.addSubviews([heroImage])
        
        heroImage
            .edgeToSuperView()
    }
    
    func setImageHeight(_ height: CGFloat) {
        heroImage.height(height)
    }
    
    func loadData(_ url: String?) {
        let urlBR = url?.replacingOccurrences(of: "lorempixel.com", with: "lorempixel.com.br")
        heroImage.loadImageWith(urlPath: urlBR,
                                placeholderImage: UIImage(named: "placeholder"),
                                loadCacheEnabled: true)
    }
    
    private var minimumHeight: CGFloat {
        get {
            guard let scrollView = scrollView else { return 0 }
            if let cachedSize = cachedMinimumSize {
                if cachedSize.width == scrollView.frame.width {
                    return cachedSize.height
                }
            }
         
            // Ask Auto Layout what the minimum height of the header should be.
            let minimumSize = systemLayoutSizeFitting(CGSize(width: scrollView.frame.width, height: 0),
                                                      withHorizontalFittingPriority: .required,
                                                      verticalFittingPriority: .defaultLow)
            cachedMinimumSize = minimumSize
            return minimumSize.height
        }
    }

    func updatePosition() {
        guard let scrollView = scrollView else { return }
        
        // Calculate the minimum size the header's constraints will fit
        let minimumSize = minimumHeight
        
        // Calculate the baseline header height and vertical position
        let referenceOffset = scrollView.safeAreaInsets.top
        let referenceHeight = scrollView.contentInset.top - referenceOffset
        
        // Calculate the new frame size and position
        let offset = referenceHeight + scrollView.contentOffset.y
        let targetHeight = referenceHeight - offset - referenceOffset
        var targetOffset = referenceOffset
        if targetHeight < minimumSize {
            targetOffset += targetHeight - minimumSize
        }
        
        // Update the header's height and vertical position.
        var headerFrame = frame
        headerFrame.size.height = max(minimumSize, targetHeight)
        headerFrame.origin.y = targetOffset
        
        frame = headerFrame
    }
}
