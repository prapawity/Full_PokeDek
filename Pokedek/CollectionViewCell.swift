//
//  CollectionViewCell.swift
//  Pokedek
//
//  Created by Prapawit Patthasirivichot on 13/10/2562 BE.
//  Copyright © 2562 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit
import Kingfisher
import LoadingPlaceholderView
class CollectionViewCell: UICollectionViewCell {
    let loadingPlace = LoadingPlaceholderView()
    @IBOutlet weak var showUIView: UIView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadingPlace.cover(showUIView, animated: true)
    }
    
    func setImg(url:String,name:String){
        self.img.kf.setImage(with:URL(string: url), placeholder: nil, options: nil, progressBlock: nil) { result in
            self.name.text = name
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingPlace.uncover(animated: true)
            }
        }
        
        
    }

}
