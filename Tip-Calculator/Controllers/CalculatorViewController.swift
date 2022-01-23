//
//  ViewController.swift
//  Tip-Calculator
//
//  Created by Vicky Lee on 16/1/2022.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.1
    var splitNumber = 2
    var amountForEachPerson = 0.0
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        // Deselect all tips button
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        
        // Remove %
        let removePercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsNumber = Double(removePercentSign)!
        
        tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let stepperValue = sender.value
        splitNumber = Int(stepperValue)
        splitNumberLabel.text = String(splitNumber)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billAmount = Double(billTextField.text!) ?? 0.0
        
        if billAmount > 0.0 {
            amountForEachPerson = billAmount * Double(1+tip) / Double(splitNumber)
            self.performSegue(withIdentifier: "goToResult", sender: self)
            
        } else {
            // create the alert
            let alert = UIAlertController(title: "Alert", message: "Please enter bill total first.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destincationVC = segue.destination as! ResultViewController
            destincationVC.amountToPay = String(format: "%.2f", amountForEachPerson)
            destincationVC.numberOfPeople = splitNumber
            destincationVC.tipPercentage = getTipPercentage()
        }
    }
    
    func getTipPercentage() -> String {
        let tip = Int(tip * 100)
        let tipWithPercentage = String("\(tip)%")
        
        return tipWithPercentage;
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}

