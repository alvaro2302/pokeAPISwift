//
//  PokemonManager.swift
//  who is that pokemon
//
//  Created by Alvaro Cuiza on 19/2/23.
//

import Foundation
protocol PokemonManagerDelegate {
    func updatePokemon(pokemons: [PokemonModel])
    func didFailWithError(error:Error)
}
struct PokemonManager {
    let pokemonURL: String = "https://pokeapi.co/api/v2/pokemon?limit=898"
    var delegate: PokemonManagerDelegate?
    func fetchPokemonAPI()
    {
        performRequest(with: pokemonURL)
    }
    private func performRequest(with urlString:String){
        // 1 create url
        if let url =  URL(string: urlString){
            // 2 create url sesion
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){ data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let pokemons = self.parseJSON(pokemonData: safeData){
                        self.delegate?.updatePokemon(pokemons: pokemons)
                    }
                }
                
            }
            task.resume()
            // 3 Give the session a task
            // 4 Start the task
        }
        
    }
    private func parseJSON(pokemonData: Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemons = decodeData.results?.map{
                PokemonModel(name: $0.name , imageURL: $0.url )
            }
            return pokemons
        } catch {
            return nil
        }
    }
}
