//
//  UIImageView+Extensions.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//


import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(_ imageURL: URL) {
       // let url = URL(string: imageURL)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: imageURL,
            placeholder: UIImage(named: "logo"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
}
