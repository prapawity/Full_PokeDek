//
//  ShowDetailViewController.swift
//  Pokedek
//
//  Created by Prapawit Patthasirivichot on 13/10/2562 BE.
//  Copyright © 2562 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit
import Kingfisher
class ShowDetailViewController: UIViewController {
    var data: PokemonModel?
    @IBOutlet weak var uiview: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiview.layer.cornerRadius = 10
        self.image.kf.setImage(with:URL(string: (data?.sprites!.front_default)!))
        name.text = data?.name!

        // Do any additional setup after loading the view.
    }
    

}
