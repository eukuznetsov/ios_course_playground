//
//  ViewController.swift
//  Weather
//
//  Created by Evgeney Kuznetsov on 13/05/2018.
//  Copyright © 2018 Evgeney Kuznetsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cityField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    
    let backgroundImagesURL = URL(string: "https://unsplash.com")!
    let openWeatherToken = "f2c8543ef3b74a79810175422181305"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cityEntered(_ sender: Any) {
        if let url = URL(string: "https://api.apixu.com/v1/current.json?key=\(openWeatherToken)&q=\(cityField.text!)") {
            print("request URL: \(url)")
            countryLabel.text = ""
            resultLabel.text = "Requesting"
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) {
                data,rawResponse,error in
                
                DispatchQueue.main.async {
                    print("response received")
                    guard let data=data, error == nil else {
                        print("error: \(error)")
                        return
                    }
                    
                    if let response = rawResponse as? HTTPURLResponse {
                        print("Response code: \(response.statusCode)")
                        let result = String(data: data, encoding: String.Encoding.utf8)!
                        print(result)
                        
                        guard let jsonDecoded = try? JSONDecoder().decode(CurrentWeather.self, from: data) else {
                            guard let errorJson = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                                self.resultLabel.text = "Unknown error"
                                return
                            }
                            self.resultLabel.text = errorJson.error.message
                            return
                        }
                        
                        self.countryLabel.text = "\(jsonDecoded.location.name), \(jsonDecoded.location.country)"
                        self.resultLabel.text = String(Int(jsonDecoded.current.temperature)) + "C°"
                       
                    }
                    
                }
                
            }.resume()

        } else {
            resultLabel.text = "Enter text in English"
        }
    }
    
    func setBackground() {
        if let imageURL = getImageURL() {
            setBackgroundFromURL(imageURL)
        }
        
    }
    
    func getImageURL() -> URL? {
        let request = URLRequest(url: backgroundImagesURL)
        let semaphore = DispatchSemaphore(value: 0)
        var imageURL:URL!
        
        URLSession.shared.dataTask(with: request){
            data,rawResponse,error in
            
            //TODO: remove code smell
            defer {semaphore.signal()}
            
            print("Got response for images URL")
            guard let data=data, error == nil else {
                print("error on loading backgound: \(error)")
                return
            }
            
            guard let response = rawResponse as? HTTPURLResponse else {
                print("invalid response type")
                return
            }
            
            print("Response code: \(response.statusCode)")
            
            let result = String(data: data, encoding: String.Encoding.utf8)!
            
            guard let rexeg = try? NSRegularExpression(pattern: "(?<=srcset=\").+?(?=\\s)", options: []) else {
                print("invalid regexp")
                return
            }
            
            if let match = rexeg.firstMatch(in: result, options: [], range: NSRange(location: 0, length: result.count)) {
                imageURL = URL(string: String(result[Range(match.range, in: result)!]))
            }
        }.resume()
        semaphore.wait()
        return imageURL
    }

    func setBackgroundFromURL(_ imageURL: URL) {
        do {
            let loadedData = try Data(contentsOf: imageURL)
            backgroundImage.image = UIImage(data: loadedData)
        }catch{
            print("Error: \(error)")
        }
    }
}

