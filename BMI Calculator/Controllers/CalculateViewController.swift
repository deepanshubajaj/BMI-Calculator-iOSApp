//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Deepanshu Bajaj on 15/12/24.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showWelcomeAlert()
    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        heightLabel.text = "\(height)m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weight = String(format: "%.0f", sender.value)
        weightLabel.text = "\(weight)Kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        
        calculatorBrain.calculateBMI(height: height, weight: weight)
        performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
            
        }
    }
    
    // Alerts
    func showWelcomeAlert() {
        let message = "\nThis app helps you calculate your Body Mass Index (BMI) based on your height (in meters) and weight (in Kilograms). Enter your details and see where you stand!"
        
        let alert = UIAlertController(title: "Welcome to BMI Calculator!", message: nil, preferredStyle: .alert)
        
        let attributedMessage = NSMutableAttributedString(
            string: message,
            attributes: [
                NSAttributedString.Key.paragraphStyle: justifiedParagraphStyle(),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
            ]
        )
        
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        
        let getStartedAction = UIAlertAction(title: "Let's Get Started", style: .default, handler: nil)
        let learnMoreAction = UIAlertAction(title: "Learn More", style: .default) { _ in
            self.showLearnMoreAlert()
        }
        
        alert.addAction(getStartedAction)
        alert.addAction(learnMoreAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLearnMoreAlert() {
        let message = """
        
        BMI (Body Mass Index) is a value derived from your height and weight. It is used to categorize you into underweight, normal weight, overweight, or obese ranges. A healthy BMI is usually between 18.5 and 24.9.
        
        Consider the following ranges:
        -> Underweight: < 18.5
        -> Normal weight: 18.5 - 24.9
        -> Overweight/Obese: > 24.9
        
        """
        
        let learnMoreAlert = UIAlertController(title: "What is BMI?", message: nil, preferredStyle: .alert)
        
        let attributedMessage = NSMutableAttributedString(
            string: message,
            attributes: [
                NSAttributedString.Key.paragraphStyle: justifiedParagraphStyle(),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
            ]
        )
        
        learnMoreAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        learnMoreAlert.addAction(dismissAction)
        
        present(learnMoreAlert, animated: true, completion: nil)
    }
    
    func justifiedParagraphStyle() -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.lineBreakMode = .byWordWrapping
        return paragraphStyle
    }
    
    
}

