//
//  ViewController.swift
//  Milestone7_9
//
//  Created by Konrad Cureau on 07/04/2022.
//

import UIKit

class ViewController: UIViewController {
    var wordToFind: UILabel!
    var lifeLabel: UILabel!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","-","."]
    
    var solution = ""

    var score = 0
    var life = 7
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        lifeLabel = UILabel()
        lifeLabel.translatesAutoresizingMaskIntoConstraints = false
        lifeLabel.textAlignment = .left
        lifeLabel.text = "Life: 7/7"
        view.addSubview(lifeLabel)
        
        wordToFind = UILabel()
        wordToFind.translatesAutoresizingMaskIntoConstraints = false
        wordToFind.textAlignment = .center
        wordToFind.font = UIFont.systemFont(ofSize: 40)
        wordToFind.text = "_ _ _ _ _"
        wordToFind.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(wordToFind)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            lifeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            lifeLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            wordToFind.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordToFind.widthAnchor.constraint(equalTo: view.widthAnchor),
            wordToFind.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 240),
            buttonsView.heightAnchor.constraint(equalToConstant: 420),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: wordToFind.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
        ])
        
        let width = 60
        let height = 60
        
        for row in 0..<7 {
            for column in 0..<4 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle(letters.first, for: .normal)
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                letters.remove(at: 0)
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(loadWord), with: nil)
    }

    @objc func loadWord() {
        if let wordsFileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordsList = try? String(contentsOf: wordsFileURL) {
                let words = wordsList.components(separatedBy: "\n")
                solution = words.randomElement() ?? "SWIFT"
                
                DispatchQueue.main.async { [weak self] in
                    self?.wordToFind.text = ""
                    
                    if let solution = self?.solution {
                        for _ in solution {
                            self?.wordToFind.text?.append(" _ ")
                        }
                    }

                }
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        for letter in solution {
            let strLetter = String(letter)
            if buttonTitle == strLetter {
                
            }
        }
        
    }
}

