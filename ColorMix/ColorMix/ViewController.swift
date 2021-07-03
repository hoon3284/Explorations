//
//  ViewController.swift
//  ColorMix
//
//  Created by wickedRun on 2021/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSwitch: UISwitch!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSwitch: UISwitch!
    @IBOutlet weak var blueSlider: UISlider!
    // Circle: the filled circle indicates that the outlet is connected. If the outlet wasn't connected, it would be an empty circle.
    // @IBOutlet weak: This is a signal to Xcode that the property on this line is an outlet.
    // var colorView: This is the declaration of a property you are already familiar with.
    // : UIView! : The type of the property is UIView!. The exclamation point means that if the outlet isn't connected and you try to access this property, your app will crash. UIView is the basic view type used in all iOS apps. Almost everything you see on the screen is a kind of UIView, which is responsible for drawing and handling touches.

    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.borderWidth = 5
        colorView.layer.cornerRadius = 20
        colorView.layer.borderColor = UIColor.black.cgColor
        updateControls()
        // This code uses the layer property of a UIView, which in turn has its own properties.
    }
    
    // Troubleshooting Disconnected Outlets
    // Sometimes you'll build and run your app with no errors, but the app immediatly crashs on launch. Your device (or the simulator) shows your Home screen with an error in the console, like this:
    /* "*** Terminating app due to uncaught exception
       'NSUnknownKeyException', reason:
       '[<YourApp.ViewController 0x7f8378f05b00>
       setValue:forUndefinedKey: ]: this class is not key
       value coding-compliant for the key
       someNameFromYourApp"
    */
    // This is a common error when you're working with actions and outlets. Unfortunately, the error message doesn't tell you that the probelm actually stems from a view in Interface Builder, but that's exactly where you need to look.
    // You  can practice this now by following the instructions below, or you can skip this section and move on to Part 2.(you might want to come back later if you encounter this bug as you're developing ColorMix.)
    // It's not unusual to change the name of a variable in your code. Perhaps you misspelled it, or you thought of a better name. Do that now for the colorView property. Perhaps colorSwatch is a more descriptive name. Change the name where it's declared and where it's used in viewDidLoad().
    @IBAction func switchChanged(_ sender: UISwitch) {
        // Circle: The filled circle indicates that the action is connected.
        // @IBAction: This line signals to Xcode that the method on this line is an action connected to a control in Interface Builder.
        // sender: The sender argument is the UI element that initiated the action. You chose the type UISwitch, since you know that's the type of storyboard object connected to this IBAcion.
//        if sender.isOn {
//            colorView.backgroundColor = .red
//        } else {
//            colorView.backgroundColor = .black
//        }
        updateColor()
        updateControls()
    }
    
    func updateColor() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        if redSwitch.isOn {
            red = CGFloat(redSlider.value)
        }
        if greenSwitch.isOn {
            green = CGFloat(greenSlider.value)
        }
        if blueSwitch.isOn {
            blue = CGFloat(blueSlider.value)
        }
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        colorView.backgroundColor = color
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func reset(_ sender: Any) {
        colorView.backgroundColor = .white
        redSwitch.isOn = false
        greenSwitch.isOn = false
        blueSwitch.isOn = false
        redSlider.value = 1
        greenSlider.value = 1
        blueSlider.value = 1
        updateControls()
    }
    
    func updateControls() {
        redSlider.isEnabled = redSwitch.isOn
        greenSlider.isEnabled = greenSwitch.isOn
        blueSlider.isEnabled = blueSwitch.isOn
    }
    
}

