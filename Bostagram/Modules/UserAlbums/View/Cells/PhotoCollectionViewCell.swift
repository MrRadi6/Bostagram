//
//  PhotoCollectionViewCell.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!

    func bind(with imageURL: String) {
        guard let url = URL(string: imageURL) else {
            return
        }
        imageView.kf.setImage(with: url,
                              options: [
                                      .loadDiskFileSynchronously,
                                      .cacheOriginalImage,
                                      .transition(.fade(0.25))])
    }
}
