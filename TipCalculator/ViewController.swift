//
//  ViewController.swift
//  TipCalculator
//
//  Created by Yuki Tsukada on 2021/01/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var billAmountTextField: UITextField!
    
    @IBOutlet var tipPercentageSlider: UISlider!
    
    @IBOutlet var tipPercentageLabel: UILabel!
    @IBOutlet var calculateTipButton: UIButton!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotification()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        
        // set default value for the slider
        tipPercentageSlider.value = 15
        tipPercentageLabel.text = "\(Int(tipPercentageSlider.value)) %"
        
        // set placeholder for the text field
        billAmountTextField.placeholder = "Bill Amount"
        
        // add color to the button
        calculateTipButton.backgroundColor = .cyan
        calculateTipButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        // add color to the slider
        tipPercentageSlider.tintColor = .cyan
        tipPercentageSlider.thumbTintColor = .cyan
        
        // add shadow to the label
        tipAmountLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        tipAmountLabel.layer.shadowOpacity = 0.5
        tipAmountLabel.layer.shadowRadius = 2
        tipAmountLabel.layer.shadowColor = CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        
        // add shadow to the button label
        calculateTipButton.titleLabel!.layer.shadowColor = UIColor.black.cgColor
        calculateTipButton.titleLabel!.layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
        calculateTipButton.titleLabel!.layer.shadowOpacity = 0.5
        calculateTipButton.titleLabel!.layer.shadowRadius = 0
        calculateTipButton.titleLabel!.layer.masksToBounds = false
    }

    @IBAction func adjustTipPercentage(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        tipPercentageLabel.text = "\(currentValue) %"
    }
    
    // after implementing textFieldValueChanged and sliderValueChanged, buttonClicked became almost no use
    @IBAction func buttonClicked(_ sender: UIButton) {
        if billAmountTextField.text != nil {
            if Int(billAmountTextField.text!) != nil {
                let billAmountInFloat = (billAmountTextField.text! as NSString).floatValue
                let tipAmount : Float = billAmountInFloat * Float(Int(tipPercentageSlider.value)) / 100
                let tipAmountInString = NSString(format: "%.2f", tipAmount)
                tipAmountLabel.text = "$ \(tipAmountInString)"
            }
            billAmountTextField.placeholder = "Bill Amount"
        }
        if billAmountTextField.text?.isEmpty == true {
            tipAmountLabel.text = "$ 00.00"
        }
    }
    
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        if billAmountTextField.text != nil {
            if Int(billAmountTextField.text!) != nil {
                let billAmountInFloat = (billAmountTextField.text! as NSString).floatValue
                let tipAmount : Float = billAmountInFloat * Float(Int(tipPercentageSlider.value)) / 100
                let tipAmountInString = NSString(format: "%.2f", tipAmount)
                tipAmountLabel.text = "$ \(tipAmountInString)"
            }
        }
        if billAmountTextField.text?.isEmpty == true {
            tipAmountLabel.text = "$ 00.00"
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        if billAmountTextField.text != nil {
            if Int(billAmountTextField.text!) != nil {
                let billAmountInFloat = (billAmountTextField.text! as NSString).floatValue
                let tipAmount : Float = billAmountInFloat * Float(Int(tipPercentageSlider.value)) / 100
                let tipAmountInString = NSString(format: "%.2f", tipAmount)
                tipAmountLabel.text = "$ \(tipAmountInString)"
            }
        }
        if billAmountTextField.text?.isEmpty == true {
            tipAmountLabel.text = "$ 00.00"
        }
    }
    
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    fileprivate func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
      guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
      
      let keyboardFrame = keyboardFrameValue.cgRectValue
      let keyboardHeight = keyboardFrame.size.height
      
      let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }

}


