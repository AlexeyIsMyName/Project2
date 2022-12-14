//
//  ViewController.swift
//  Project2
//
//  Created by ALEKSEY SUSLOV on 18.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
            showScore()
        }
    }
    
    var correctAnswer = 0
    var askedQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showScore()
        
        countries = [
            "estonia",
            "france",
            "germany",
            "ireland",
            "italy",
            "monaco",
            "nigeria",
            "poland",
            "russia",
            "spain",
            "uk",
            "us"
        ]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Guess: \(countries[correctAnswer].uppercased())"
        askedQuestions += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        var message: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)."
        } else {
            title = "Wrong!"
            score -= 1
            message = "That???s the flag of \(countries[sender.tag].uppercased())"
        }
        
        guard askedQuestions < 10 else {
            let ac = UIAlertController(title: "End Game",
                                       message: "\(title). \(message).",
                                       preferredStyle: .alert)

            ac.addAction(UIAlertAction(title: "New Game",
                                       style: .default,
                                       handler: askQuestion))

            present(ac, animated: true)
            
            score = 0
            askedQuestions = 0
            return
        }
        
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "Continue",
                                   style: .default,
                                   handler: askQuestion))

        present(ac, animated: true)
    }
    
    private func showScore() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(score)",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }
}

