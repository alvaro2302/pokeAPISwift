//
//  ResultViewController.swift
//  who is that pokemon
//
//  Created by Alvaro Cuiza on 9/3/23.
//

import UIKit
import Kingfisher

class ResultViewController: UIViewController {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var buttonAgain: UIButton!
    
    @IBOutlet weak var imagePokemon: UIImageView!
    var pokemonName: String = ""
    var pokemonImageURL: String = ""
    var finalScore: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        labelScore.text = "Perdiste, tu puntaje fue de \(finalScore)"
        labelText.text = "No, es un \(pokemonName)"
        imagePokemon.kf.setImage(with: URL(string: pokemonImageURL))
    }
    

    @IBAction func playAgainPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
