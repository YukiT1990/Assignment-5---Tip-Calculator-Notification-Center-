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
        
        billAmountTextField.placeholder = "Bill Amount"
        
        
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        tipPercentageLabel.text = "\(currentValue) %"
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if billAmountTextField.text != nil {
            if Int(billAmountTextField.text!) != nil {
                let billAmountInFloat = (billAmountTextField.text! as NSString).floatValue
                let tipAmount : Float = billAmountInFloat * Float(tipPercentageSlider.value) / 100
                let tipAmountInString = NSString(format: "%.2f", tipAmount)
                tipAmountLabel.text = "$ \(tipAmountInString)"
            }
            billAmountTextField.placeholder = "Bill Amount"
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
      // 2. When notified, I want to ask iOS the size(height) of the keyboard
      guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
      
      let keyboardFrame = keyboardFrameValue.cgRectValue
      let keyboardHeight = keyboardFrame.size.height
      
      // 3. Tell scrollview to scroll up (height)
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


