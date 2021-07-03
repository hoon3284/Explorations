//
//  ViewController.swift
//  ElementQuiz
//
//  Created by wickedRun on 2021/06/30.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum State {
    case question
    case answer
    case score
}

// UITextView와 UITextField의 차이점 전자는 multiple-line editing for long-form text, 반면에 후자는 small amounts of single-line text를 위해 design됨.
// 그래서 이 앱에서는 UITextField 사용.

class ViewController: UIViewController, UITextFieldDelegate {
    let fixedElementList = ChemicalElement.setupDefaultElement()
    var elementList: [ChemicalElement] = []
    var mistakes: [ChemicalElement] = []
    var currentElementIndex = 0
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case .flashCard: setupFlashCards()
            case .quiz: setupQuiz()
            }
            updateUI()
        }
    }
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var shuffleToggle: UISwitch!
    var state: State = .question

    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mode = .flashCard
    }

    func updateFlashCardUI(elementName: ChemicalElement) {
        modeSelector.selectedSegmentIndex = 0
        shuffleToggle.isHidden = false
        // Buttons
        showAnswerButton.isHidden = false
        nextButton.isEnabled = true
        nextButton.setTitle("Next Element", for: .normal)
        // Text Field and keyboard
        textField.isHidden = true
        textField.resignFirstResponder()
        
        if state == .answer {
            answerLabel.text = elementName.name
        } else {
            answerLabel.text = "?"
        }
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        state = .answer
        updateUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        if currentElementIndex == elementList.count {
            currentElementIndex = 0
            if mode == .quiz {
                state = .score
                updateUI()
                return
            }
        }
        state = .question
        
        updateUI()
    }
    
    func updateQuizUI(elementName: ChemicalElement) {
        modeSelector.selectedSegmentIndex = 1
        shuffleToggle.isHidden = true
        // Buttons
        showAnswerButton.isHidden = true
        if currentElementIndex == elementList.count - 1 {
            nextButton.setTitle("Show Score", for: .normal)
        } else {
            nextButton.setTitle("Next Question", for: .normal)
        }
        switch state {
        case .question:
            nextButton.isEnabled = false
        case .answer:
            nextButton.isEnabled = true
        case .score:
            nextButton.isEnabled = false
        }
        
        // Text field and keyboard
        textField.isHidden = false
        switch state {
        case .question:
            textField.isEnabled = true
            textField.text = ""
            textField.becomeFirstResponder()
        case .answer:
            textField.isEnabled = false
            textField.resignFirstResponder()
        case .score:
            textField.isEnabled = true
            textField.isHidden = true
            textField.resignFirstResponder()
        }
        
        // Answer Label
        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            if answerIsCorrect {
                answerLabel.text = "Correct!"
            } else {
                answerLabel.text = "❌\nCorrect Answer: \(elementName.name)"
            }
        case .score:
            answerLabel.text = ""
            displayScoreAlert()
        }
    }
    
    func updateUI() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName.imageName)
        imageView.image = image
        
        switch mode {
        case .flashCard:
            updateFlashCardUI(elementName: elementName)
        case .quiz:
            updateQuizUI(elementName: elementName)
        }
    }
    
    // Runs after the user hits the Return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Get the txt from the text field
        let textFieldContents = textField.text!
        
        // Determine whether the user answered correctly and update appropriate quiz
        // state
        if textFieldContents.lowercased() == elementList[currentElementIndex].name.lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
            mistakes.append(elementList[currentElementIndex])
        }
        
        if answerIsCorrect {
            print("Correct!")
        } else {
            print("❌")
        }
        // The app should now display the answer to the user
        state = .answer
        
        updateUI()
        
        return true
    }
    
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    // Shows an iOS alert with the user's quiz score
    func displayScoreAlert() {
        let alert = UIAlertController(
            title: "Quiz Score",
            message: "Your score is \(correctAnswerCount) out of \(elementList.count).",
            preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: scoreAlertDismissed(_:))
        
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
    
    // Sets up a new flash card session.
    func setupFlashCards() {
        state = .question
        if shuffleToggle.isOn {
            elementList = fixedElementList.shuffled()
        } else {
            elementList = fixedElementList
        }
        currentElementIndex = 0
    }
    
    // Sets up a new quiz.
    func setupQuiz() {
        state = .question
        elementList = fixedElementList.shuffled()
        currentElementIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
    }
    
    @IBAction func shufflingOption(_ sender: UISwitch) {
        mode = .flashCard
    }
}

// label에서 line을 0으로 설정한 것은 라인 수를 딱 몇으로 설정하지 않은 것. 시스템에게 any number를 말해준 것과 같음
// TextField 애트리뷰트 인스펙터창에서 Correction - No, Spell Checking - No.
// 로 설정한 것은 답을 작성할 때 autocorrect suggestion을 띄우지 않도록 설정함.
// 그리고 Return key의 모양을 설정할 수 있다. 여기서는 Done으로 설정함.


// Other Possibilities
// 1. Shuffling options ✔️
// 2. Tracking common mistakes
// 3. Eliminating learned items
// 4. Multiple-choice mode

