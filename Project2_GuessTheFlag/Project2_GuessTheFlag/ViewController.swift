//
//  ViewController.swift
//  Project2_GuessTheFlag
//
//  Created by Konrad Cureau on 05/04/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberQuestions = 0
    var bestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonView = UIImage(systemName: "graduationcap.fill")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonView, style: .plain, target: self, action: #selector(showScore))
        
        let defaults = UserDefaults.standard
        
        if let savedScore = defaults.object(forKey: "bestScore") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                bestScore = try jsonDecoder.decode(Int.self, from: savedScore)
            } catch {
                print("Failed to load best score.")
            }
        }
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " - " + "Score : " + String(score)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        var buttonText: String
        
        numberQuestions += 1
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct"
            message = "Your score is \(score)."
        } else {
            score -= 1
            title = "Wrong"
            message = "It was \(countries[sender.tag].uppercased()). Your score is \(score)."
        }
        
        if numberQuestions == 10 && score > bestScore {
            bestScore = score
            save()
            title = "New best score !"
            message = "Your new best score is \(bestScore)."
            buttonText = "Restart"
            score = 0
        } else if numberQuestions == 10 {
            message += " You answered 10 questions."
            buttonText = "Restart"
            score = 0
        } else {
            buttonText = "Continue"
        }
        
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: buttonText, style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Best score", message: "\(bestScore) points", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        
        present(ac, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(bestScore) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "bestScore")
        } else {
            print("Failed to save score.")
        }
    }
    
}

