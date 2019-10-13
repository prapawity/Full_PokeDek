//
//  PokemonModel.swift
//  Pokedek
//
//  Created by Prapawit Patthasirivichot on 13/10/2562 BE.
//  Copyright © 2562 Prapawit Patthasirivichot. All rights reserved.
//

import Foundation
class PokemonModel: Codable{
    let name:String?
    let sprites : PokemonSpriteModel?
}
class PokemonSpriteModel: Codable {
    var front_default: String?
}
