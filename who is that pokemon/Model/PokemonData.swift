//
//  Pokemon.swift
//  who is that pokemon
//
//  Created by Alvaro Cuiza on 19/2/23.
//

import Foundation

struct PokemonData :Codable {
    let results:[Result]?
    
    
}

struct Result : Codable {
    let name: String
    let url: String
}
