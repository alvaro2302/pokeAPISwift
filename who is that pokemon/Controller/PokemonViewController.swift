//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit

class PokemonViewController: UIViewController {
   
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    lazy var pokemonManager = PokemonManager();
    override func viewDidLoad() {
        super.viewDidLoad()
        labelScore.text = "Puntaje: 100"
        createButtons()
        pokemonManager.fetchPokemonAPI()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.title(for: .normal)!)
    }
    func createButtons(){
        for answerButton in answerButtons{
            answerButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            answerButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            answerButton.layer.shadowOpacity = 1.0
            answerButton.layer.shadowRadius = 0
            answerButton.layer.cornerRadius = 10.0
        }

    }
    
    
}
extension PokemonViewController: PokemonManagerDelegate{
    func updatePokemon(pokemons: [PokemonModel]) {
        print(pokemons)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
