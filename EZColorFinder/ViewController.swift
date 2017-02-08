//
//  ViewController.swift
//  EZColorFinder
//
//  Created by Leo on 2017/2/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // color slider
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    // color value text field
    @IBOutlet weak var redValueTextField: UITextField!
    @IBOutlet weak var greenValueTextField: UITextField!
    @IBOutlet weak var blueValueTextField: UITextField!
    @IBOutlet weak var hexValueTextField: UITextField!

    // view for display color
    @IBOutlet weak var colorView: UIView!
    
    // color value
    var redValue:Int = 0
    var greenValue:Int = 0
    var blueValue:Int = 0
    
    var isChanged:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValue = Int(redValueTextField.text!)!
        greenValue = Int(greenValueTextField.text!)!
        blueValue = Int(blueValueTextField.text!)!
        
        // Set border
        colorView.layer.borderWidth = 1.0;
        colorView.layer.cornerRadius = 5.0;
        
        setHexAndView(red: redValue, green: greenValue, blue: blueValue)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let senderValue:Int = Int(sender.value);
        
        switch sender {
        case redSlider:
            redValue = senderValue
            redValueTextField.text = "\(senderValue)"
            break
        case greenSlider:
            greenValue = senderValue
            greenValueTextField.text = "\(senderValue)"
            break
        case blueSlider:
            blueValue = senderValue
            blueValueTextField.text = "\(senderValue)"
            break
        default:
            break
        }
        
        setHexAndView(red: redValue, green: greenValue, blue: blueValue)
    }
    
    // MARK: Text Field Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == hexValueTextField {
            
            if let text:String = textField.text {
                
                // no input
                if text == "", text.characters.count != 6 {
                    textField.text = String(format: "%02x%02x%02x", Int(redSlider.value), Int(greenSlider.value), Int(blueSlider.value))
                }
                else {
                    
                    // error input
                    for c:Character in text.characters {
                        if c < "0" || (c > "9" && c < "A") || (c > "F" && c < "a") || c > "f" {
                            textField.text = String(format: "%02x%02x%02x", Int(redSlider.value), Int(greenSlider.value), Int(blueSlider.value))
                            return
                        }
                    }
                    
                    var start:String.Index = text.startIndex
                    var end:String.Index = text.index(start, offsetBy: 2)
                    var range:Range<String.Index> = start ..< end

                    let redValueStr:String = text.substring(with: range)
                    
                    start = end
                    end = text.index(start, offsetBy: 2)
                    range = start ..< end
                    let greenValueStr:String = text.substring(with: range)
                    
                    start = end
                    end = text.index(start, offsetBy: 2)
                    range = start ..< end
                    let blueValueStr:String = text.substring(with: range)
                    
                    
                    
                    redValue = Int(redValueStr, radix: 16)!
                    greenValue = Int(greenValueStr, radix: 16)!
                    blueValue = Int(blueValueStr, radix: 16)!
                    
                    colorView.backgroundColor = UIColor(red: CGFloat(redValue)/255.0, green: CGFloat(greenValue)/255.0, blue: CGFloat(blueValue)/255.0, alpha: 1.0)
                    
                    redSlider.value = Float(redValue)
                    greenSlider.value = Float(greenValue)
                    blueSlider.value = Float(blueValue)
                    
                    redValueTextField.text = "\(redValue)"
                    greenValueTextField.text = "\(greenValue)"
                    blueValueTextField.text = "\(blueValue)"
                }
            }
        }
        else {
            
            // no input
            if let text:String = textField.text, text == "" {
                    textField.text = "0"
            }
            
            var value:Int = Int(textField.text!)!
            
            if value > 255 {
                value = 255
            }
            
            textField.text = "\(value)"
            
            switch textField {
            case redValueTextField:
                redValue = value
                redSlider.value = Float(value)
                break
            case greenValueTextField:
                greenValue = value
                greenSlider.value = Float(value)
                break
            case blueValueTextField:
                blueValue = value
                blueSlider.value = Float(value)
                break
            default:
                break
            }
            
            setHexAndView(red: redValue, green: greenValue, blue: blueValue)
        }
    }
    
    // MARK: Set Hex Value & View
    func setHexAndView(red:Int, green:Int, blue:Int) {
        colorView.backgroundColor = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
        
        hexValueTextField.text = String(format: "%02x%02x%02x", red, green, blue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

