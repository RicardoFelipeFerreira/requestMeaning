//
//  ViewController.swift
//  APIowlbot
//
//  Created by Ricardo Ferreira on 18/05/18.
//  Copyright © 2018 Ricardo Ferreira. All rights reserved.
//

import UIKit
import Alamofire

struct Meaning:Decodable{
    let definition: String
    let example: String
}

class ViewController: UIViewController {
    
    var meaning = [Meaning]()
    let wordString = ["excuse", "acquire", "champagne"]
    var diceRoll:Int {
        get{
            return Int(arc4random_uniform(3))
        }
    }
    var word = "strong"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://owlbot.info/api/v2/dictionary/\(wordString[diceRoll])")
        Alamofire.request(url!).responseJSON(completionHandler: { (response) in
            let result = response.data
            do{
                self.meaning = try JSONDecoder().decode([Meaning].self, from: result!)
                
                for meaning in self.meaning{
                    print("Definition:", meaning.definition, "\nExample:", meaning.example)
                }
            
            }catch{
                print("error")
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

