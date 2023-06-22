//
//  ImageViewExtension.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 19/06/2023.
//

import UIKit
import Kingfisher

extension UIImageView{
    func setImage(url:String,contentMode:UIImageView.ContentMode){
//        let indicator = loadingIndicator()
        let imageURL  = URL(string: url)
        self.kf.setImage(with: imageURL)
        self.contentMode = contentMode
    }
}
