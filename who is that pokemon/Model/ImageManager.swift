//
//  ImageManager.swift
//  who is that pokemon
//
//  Created by Alvaro Cuiza on 19/2/23.
//

import Foundation
protocol ImageManagerDelegate {
    func updateImage(image: ImageModel)
    func didFailWithErrorImage(error:Error)
}
struct ImageManager {
    var delegate: ImageManagerDelegate?
    func fetchImage(with url:String)
    {
        performRequest(with: url)
    }
    private func performRequest(with urlString:String){
        // 1 create url
        if let url =  URL(string: urlString){
            // 2 create url sesion
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){ data, response, error in
                if error != nil {
                    self.delegate?.didFailWithErrorImage(error: error!)
                }
                if let safeData = data {
                    if let image = self.parseJSON(imageData: safeData){
                        self.delegate?.updateImage(image: image)
                    }
                   
                }
                
            }
            task.resume()
            // 3 Give the session a task
            // 4 Start the task
        }
        
    }
    private func parseJSON(imageData: Data) -> ImageModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(ImageData.self, from: imageData)
            guard let imagePokemonDataUrl = decodeData.sprites.other?.officialArtwork.frontDefault else { return nil };
            let imageModel = ImageModel(frontDefault: imagePokemonDataUrl)
            return imageModel
        } catch {
            return nil
        }
    }
}
