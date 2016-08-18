//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
// TODO: the combination of checkAnswer + delay gives players a chance to cheat or mistakenly break the game:
// if one taps a button multiple times, they can increment the counter beyond the number of rounds,
// leading to endless loop of questions. Or they can skip ahead to the victory screen by tapping a correct answer four times.

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var askedIndexes: [Int] = [] // indexes of questions asked. Check this against selected question.
                                 // if it matches, then find another question.
                                 // We could pop/remove questions from our Trivia.questions array, but we would need
                                 // additional logic to repopulate the array for a new game.
    let trivia = Trivia()
    
    @IBOutlet weak var questionField: UILabel!
    // IBOutletCollection would be good here, in order to setup and tear down various things.
    @IBOutlet weak var choiceA: UIButton!
    @IBOutlet weak var choiceB: UIButton!
    @IBOutlet weak var choiceC: UIButton!
    @IBOutlet weak var choiceD: UIButton!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    var gameSound = Sound(soundID: 0, name: "GameSound")
    var success = Sound(soundID: 1, name: "success")
    var failure = Sound(soundID: 2, name: "failure")

    override func viewDidLoad() {
        super.viewDidLoad()
        gameSound.prepareSound()
        success.prepareSound()
        failure.prepareSound()
        // Start game
        gameSound.play()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        indexOfSelectedQuestion = getRandomNumFor(trivia.questions.count)
        setUpChoices(indexOfSelectedQuestion)
        let question = trivia.questions[indexOfSelectedQuestion]
        questionField.text = question.text
        playAgainButton.hidden = true
    }
    
    func setUpChoices(questionIndex: Int) {
        let questionButtons = [choiceA,choiceB,choiceC,choiceD]
        let question = trivia.questions[questionIndex]
        var choices = question.choices
        // reset hiding of buttons.
        showAllChoices()
        resetButtons()
        if (choices.count == 2) {
            choiceA.setTitle("True", forState: .Normal)
            choiceB.setTitle("False", forState: .Normal)
            choiceC.hidden = true
            choiceD.hidden = true
        } else if (choices.count == 3) {
            let choice1 = choices.removeAtIndex(getRandomNumFor(choices.count))
            let choice2 = choices.removeAtIndex(getRandomNumFor(choices.count))
            let choice3 = choices.popLast()
            
            choiceA.setTitle(choice1, forState: .Normal)
            choiceB.setTitle(choice2, forState: .Normal)
            choiceC.setTitle(choice3, forState: .Normal)
            choiceD.hidden = true
        } else if (choices.count == 4) {
            for button in questionButtons {
                let buttonText = choices.removeAtIndex(getRandomNumFor(choices.count))
                button.setTitle(buttonText, forState: .Normal)
            }
        }
    }
    
    func displayScore() {
        // Hide the answer buttons
        hideChoices()
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    // TODO: Limit touches to 1, or disable the buttons in some way to prevent breaking the game.
    @IBAction func checkAnswer(sender: UIButton) {
        highlightAnswer()
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        let question = trivia.questions[indexOfSelectedQuestion]
        let correctAnswer = question.correctAnswer
    
        if (sender.titleLabel?.text == correctAnswer) {
            correctQuestions += 1
            success.play()
            questionField.text = "Correct!"
        } else {
            failure.play()
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        // Checking equality here can lead to an endless loop of questions.
        if questionsAsked >= questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        showAllChoices()
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
    // MARK: Helper Methods
    // Bunch of repetition here. Polish this up.
    func hideChoices() {
        let choices = [choiceA,choiceB,choiceC,choiceD]
        for button in choices {
            button.hidden = true
        }
    }
    
    func showAllChoices() {
        let choices = [choiceA,choiceB,choiceC,choiceD]
        for button in choices {
            button.hidden = false
        }
    }
    
    func resetButtons() {
        let choices = [choiceA,choiceB,choiceC,choiceD]
        
        for button in choices {
            button.enabled = true
            button.backgroundColor = UIColor.init(red: 12.0/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0) // the default blue button
        }
    }
    // little less verbose than the contained function
    func getRandomNumFor(count: Int) -> Int {
        return GKRandomSource.sharedRandom().nextIntWithUpperBound(count)
    }
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func highlightAnswer() {
        let choices = [choiceA,choiceB,choiceC,choiceD]
        for button in choices {
            // set buttons to disabled so you can't tap multiple times
            button.enabled = false
            if button.titleLabel?.text == trivia.questions[indexOfSelectedQuestion].correctAnswer {
                button.backgroundColor = UIColor.init(red: 22.0/255.0, green: 136.0/255.0, blue: 28/255.0, alpha: 1.0) // a nice shade of green
            } else {
                button.backgroundColor = UIColor.init(red: 245.0/255.0, green: 56.0/255.0, blue: 74/255.0, alpha: 1.0) // a nice shade of red
            }
        }
    }
    
}

