//
//  UIImageView+download.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit
import Kingfisher

public extension UIImageView {
    
    func loadImageWith(urlPath: String?, placeholderImage: UIImage? = nil,
                       loadCacheEnabled: Bool = false, completion: ((String?) -> Void)? = nil) {
        guard let urlPath = urlPath else {
            completion?(nil)
            return
        }

        let validUrl = URL(string: urlPath)
        DispatchQueue.main.async {
            self.kf.setImage(
                with: validUrl,
                placeholder: placeholderImage,
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .loadDiskFileSynchronously,
                    self.isLoadCacheEnabled(loadCacheEnabled)
                ]){ result in
                switch result {
                case .success(let response):
                    let imageData = response.image.jpegData(compressionQuality: 0.5)?.base64EncodedString()
                    completion?(imageData)
                case .failure:
                    completion?(nil)
                }
            }
        }
    }
    
    private func isLoadCacheEnabled(_ loadCacheEnabled: Bool) -> KingfisherOptionsInfoItem {
        loadCacheEnabled ? .cacheMemoryOnly : .forceRefresh
    }
}
