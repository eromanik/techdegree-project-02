//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

// Empty variable to hold the current question during play
var currentQuestion = Question(question: "", answers: [], correctAnswerIndex: 0)

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0

    // Flag used by timer to indicate whether the player has answered the current question
    var questionAnswered = false
    
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 1
    var wrongSound: SystemSoundID = 2
   
    // Hidden dummy button used only for getting default font and background colors
    @IBOutlet weak var defaultButton: UIButton!
    
    @IBOutlet weak var questionField: UILabel!

    @IBOutlet weak var correctIncorrectMessage: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var nextQuestion: UIButton!
    
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        correctIncorrectMessage.text = ""
        loadGameStartSound()
        loadCorrectAnswerSound()
        loadWrongAnswerSound()
        // Start game
        initializeQuestions()
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        //Start 15 second timer
        resetTimer()
        questionAnswered = false
        currentQuestion = getNextQuestion()
        
        // Display the questions
        questionField.text = currentQuestion.question
        
        // Reset background and text for buttons to match the default button
        answer1Button.backgroundColor = defaultButton.backgroundColor
        answer1Button.setTitleColor(defaultButton.titleColor(for: .normal), for: .normal)
        answer2Button.backgroundColor = defaultButton.backgroundColor
        answer2Button.setTitleColor(defaultButton.titleColor(for: .normal), for: .normal)
        answer3Button.backgroundColor = defaultButton.backgroundColor
        answer3Button.setTitleColor(defaultButton.titleColor(for: .normal), for: .normal)
        answer4Button.backgroundColor = defaultButton.backgroundColor
        answer4Button.setTitleColor(defaultButton.titleColor(for: .normal), for: .normal)
        
        // Display buttons and set answer text -- Always show the first 2 answer buttons because no question will have fewer than 2 questions
        answer1Button.isHidden = false
        answer1Button.setTitle(currentQuestion.answers[0], for: .normal)
        answer2Button.isHidden = false
        answer2Button.setTitle(currentQuestion.answers[1], for: .normal)
        
        // Display third and fourth buttons and set answer text if needed
        if currentQuestion.answers.count > 2 {
            answer3Button.isHidden = false
            answer3Button.setTitle(currentQuestion.answers[2], for: .normal)
        } else {
            answer3Button.isHidden = true
        }
        
        if currentQuestion.answers.count > 3 {
            answer4Button.isHidden = false
            answer4Button.setTitle(currentQuestion.answers[3], for: .normal)
        } else {
            answer4Button.isHidden = true
        }
        
        playAgainButton.isHidden = true
        nextQuestion.isHidden = true
    }
    
    // Grey out incorrect answer buttons and highlight correct answer
    
    func showCorrectAnswer(correctButton: UIButton) {
        answer1Button.backgroundColor = UIColor.darkGray
        answer1Button.setTitleColor(.gray, for: .normal)
        answer2Button.backgroundColor = UIColor.darkGray
        answer2Button.setTitleColor(.gray, for: .normal)
        answer3Button.backgroundColor = UIColor.darkGray
        answer3Button.setTitleColor(.gray, for: .normal)
        answer4Button.backgroundColor = UIColor.darkGray
        answer4Button.setTitleColor(.gray, for: .normal)
        correctButton.setTitleColor(.white, for: .normal)
    }
    
    func displayScore() {
        // Hide the answer buttons
        answer1Button.isHidden = true
        answer2Button.isHidden = true
        answer3Button.isHidden = true
        answer4Button.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        //Set question answered flag for timer
        questionAnswered = true
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        var selectedAnswer: Int
        
        // Translate selected button to index value to match the question struct property
        
        switch sender {
        case answer1Button:
            selectedAnswer = 0
        case answer2Button:
            selectedAnswer = 1
        case answer3Button:
            selectedAnswer = 2
        case answer4Button:
            selectedAnswer = 3
        default:
            selectedAnswer = 0
        }
        
        if currentQuestion.checkAnswer(forPlayerAnswer: selectedAnswer) {
            correctQuestions += 1
            correctIncorrectMessage.textColor = UIColor.green
            correctIncorrectMessage.text = "Correct!"
            playCorrectAnswerSound()
        } else {
            correctIncorrectMessage.textColor = UIColor.orange
            correctIncorrectMessage.text = "Sorry, wrong answer!"
            playWrongAnswerSound()
        }
        
        showCorrectAnswer(correctButton: correctAnswerButton(correctAnswerIndex: currentQuestion.correctAnswerIndex))
       
        // Display the Next Question button
        nextQuestion.isHidden = false
        
    }
    
    func correctAnswerButton(correctAnswerIndex: Int) -> UIButton {
        switch currentQuestion.correctAnswerIndex {
        case 0:
            return answer1Button
        case 1:
            return answer2Button
        case 2:
            return answer3Button
        case 3:
            return answer4Button
        default:
            return answer1Button
        }
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        nextRound()
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            correctIncorrectMessage.text = ""
            nextQuestion.isHidden = true
            displayScore()
        } else {
            // Continue game
            correctIncorrectMessage.text = ""
            questions.remove(at: indexOfSelectedQuestion)
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        initializeQuestions()
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
    // MARK: Helper Methods
    
    // Timeout for questions
    
    weak var timer: Timer?
    
    func resetTimer() {
        timer?.invalidate()
        timer = .scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(handleIdleEvent(_:)), userInfo: nil, repeats: false)
    }
    
    @objc func handleIdleEvent(_ timer: Timer) {
        
        if questionAnswered == false {
            self.correctIncorrectMessage.textColor = UIColor.orange
            self.correctIncorrectMessage.text = "Time's up!"
            self.playWrongAnswerSound()
            
            self.showCorrectAnswer(correctButton: self.correctAnswerButton(correctAnswerIndex: currentQuestion.correctAnswerIndex))
        
            nextQuestion.isHidden = false
        
            questionAnswered = true
            
            // Increment the questions asked counter
            questionsAsked += 1
        }
        
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func loadCorrectAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "cheer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctSound)
    }
    
    func loadWrongAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "boo", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
}

