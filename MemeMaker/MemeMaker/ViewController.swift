//
//  ViewController.swift
//  MemeMaker
//
//  Created by wickedRun on 2021/06/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bottomSegmentedControl: UISegmentedControl!
    @IBOutlet weak var topCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionLabel: UILabel!
    
    var topChoices = [
        CaptionOption(emoji: "🕶",caption: "You know what's cool?"),
        CaptionOption(emoji: "💥",caption: "You know what makes me mad?"),
        CaptionOption(emoji: "💕",caption: "You know what I love?")
    ]
    var bottomChoices = [
        CaptionOption(emoji: "🐱",caption: "Cats wearing hats"),
        CaptionOption(emoji: "🐕",caption: "Dogs carrying logs"),
        CaptionOption(emoji: "🐒",caption: "Monkeys being funky")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topSegmentedControl.removeAllSegments()
        for choice in topChoices {
            topSegmentedControl.insertSegment(withTitle: choice.emoji, at: topChoices.count, animated: false)
            // animated는 viewDidLoad에서 하니까 보여줄 필요가 없어서 false
        }
        topSegmentedControl.selectedSegmentIndex = 0
        topChangeCaption(at: 0)
        bottomSegmentedControl.removeAllSegments()
        for choice in bottomChoices {
            bottomSegmentedControl.insertSegment(withTitle: choice.emoji, at: bottomChoices.count, animated: false)
            // animated는 viewDidLoad에서 하니까 보여줄 필요가 없어서 false
        }
        bottomSegmentedControl.selectedSegmentIndex = 0
        bottomChangeCaption(at: 0)
    }
    
    @IBAction func selectSegmentControl(_ sender: UISegmentedControl) {
        if sender == topSegmentedControl {
            topChangeCaption(at: sender.selectedSegmentIndex)
        } else {
            bottomChangeCaption(at: sender.selectedSegmentIndex)
        }
    }
    
    func topChangeCaption(at index: Int) {
        topCaptionLabel.text = topChoices[index].caption
    }

    func bottomChangeCaption(at index: Int) {
        bottomCaptionLabel.text = bottomChoices[index].caption
    }
    
    @IBAction func dragTopLabel(_ sender: UIPanGestureRecognizer) {
        // state - began, changed, ended, cancelled
        // changed - user's touch is moving on the screen.
        // If the user's touch is moving, you want to update the position of the label.
        if sender.state == .changed {
            topCaptionLabel.center = sender.location(in: view)
        }
        // location(in:) method of UIGestureRecognizer returns the x and y coordinates(in CGPoint) of the touch that the recognizer is tracking.
        // Passing view as the argument tells the method that you want the location relative to the top-level view of the scene--the one that contains the label.
    }
    
    @IBAction func dragBottomLabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            bottomCaptionLabel.center = sender.location(in: view)
        }
    }
}

