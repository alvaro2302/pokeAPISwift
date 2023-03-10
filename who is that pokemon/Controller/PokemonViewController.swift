//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit
import Kingfisher
class PokemonViewController: UIViewController {
   
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var labelMessage: UILabel!
    lazy var pokemonManager = PokemonManager();
    lazy var imageManager = ImageManager()
    var game = GameModel(score: 0)
    var randomPokemons: [PokemonModel] = [] {
        didSet {
            setButtonTitles()
        }
    }
    var correctAnswer: String = ""
    var correctAnswerImage: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        imageManager.delegate = self
        createButtons()
        pokemonManager.fetchPokemonAPI()
        labelMessage.text = ""
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.title(for: .normal)!
        if game.isCorrectAnswer(userAnswer, correctAnswer)
        {
            labelMessage.text = "Si es un \(correctAnswer)"
            labelScore.text = "Puntaje : \(game.getScore())"
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.layer.borderWidth = 2
            let url = URL(string: correctAnswerImage)
            pokemonImage.kf.setImage(with: url)
            Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { _ in
                self.pokemonManager.fetchPokemonAPI()
                self.labelMessage.text = " "
                sender.layer.borderWidth = 0
            }
           
        }
        else
        {
//            labelMessage.text = "no es un \(correctAnswer)"
//            sender.layer.borderColor = UIColor.systemRed.cgColor
//            sender.layer.borderWidth = 2
//            let url = URL(string: correctAnswerImage)
//            pokemonImage.kf.setImage(with: url)
//            Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { _ in
//                self.resetGame()
//                sender.layer.borderWidth = 0
//            }
            self.performSegue(withIdentifier: "goToResult", sender: self)
           
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToResult" {
            let destination = segue.destination as! ResultViewController
            destination.pokemonName = correctAnswer
            destination.pokemonImageURL = correctAnswerImage
            destination.finalScore = game.score
            resetGame()
        }
    }
    func resetGame() {
        self.pokemonManager.fetchPokemonAPI()
        game.setScore(0)
        labelScore.text = "Puntaje : \(game.getScore())"
        labelMessage.text = " "
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
    func setButtonTitles() {
        for( index, button) in answerButtons.enumerated(){
            DispatchQueue.main.async { [self] in
                button.setTitle(randomPokemons[safe: index]?.name.capitalized,for: .normal)
            }
        }
    }
    
    
}
extension PokemonViewController: PokemonManagerDelegate{
    func updatePokemon(pokemons: [PokemonModel]) {
        randomPokemons = pokemons.choose(4)
        let index = Int.random(in: 0...3)
        let imageData = randomPokemons[index].imageURL
        correctAnswer = randomPokemons[index].name
        imageManager.fetchImage(with: imageData)
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
extension PokemonViewController: ImageManagerDelegate{
    func updateImage(image: ImageModel) {
        correctAnswerImage = image.frontDefault
        DispatchQueue.main.async { [self] in
            let url = URL(string: image.frontDefault)
            let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
            pokemonImage.kf.setImage(with: url, options: [.processor(effect)])
        }
    }
    
    func didFailWithErrorImage(error: Error) {
        print(error)
    }
    
    
    
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index]: nil
    }
}

extension Collection {
    func choose(_ n:Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
