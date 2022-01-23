//
//  ResultViewController.swift
//  Tip-Calculator
//
//  Created by Vicky Lee on 22/1/2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var calculatedResult: UILabel!
    @IBOutlet weak var calculatedDescription: UILabel!
    
    var amountToPay: String?
    var numberOfPeople: Int?
    var tipPercentage: String?
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        
        calculatedResult.text = amountToPay!
        calculatedDescription.text = getResultDescription()
    }
    
    func getResultDescription() -> String {
        let description = "Split between \(numberOfPeople!) people, with \(tipPercentage!) of tip."
        return description;
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
