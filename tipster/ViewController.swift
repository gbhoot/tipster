//
//  ViewController.swift
//  tipster
//
//  Created by Gurpal Bhoot on 10/30/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IB-Outlets
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var firstPercentageLbl: UILabel!
    @IBOutlet weak var secondPercentageLbl: UILabel!
    @IBOutlet weak var lastPercentageLbl: UILabel!
    
    @IBOutlet weak var firstTipLbl: UILabel!
    @IBOutlet weak var secondTipLbl: UILabel!
    @IBOutlet weak var lastTipLbl: UILabel!
    @IBOutlet weak var firstTotalLbl: UILabel!
    @IBOutlet weak var secondTotalLbl: UILabel!
    @IBOutlet weak var lastTotalLbl: UILabel!
    
    @IBOutlet weak var tipLbl: UILabel!
    @IBOutlet weak var partySizeLbl: UILabel!
    
    // Variables
    var tipPercentages: [Double] = [0.05, 0.1, 0.15, 0.2, 0.5, 0.75, 1, 1.5, 2, 5]
    var tipA = 0, tipB = 1, tipC = 2
    var tipAmountA = 0.00, tipAmountB = 0.00, tipAmountC = 0.00
    var totalStr = String()
    var totalAmount = 0.00
    var partySize: Double = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupView()
    }
    
    // Functions
    func setupView() {
        totalAmountLbl.text = "$0.00"
        updateTipLabels()
        tipLbl.text = "Tip %"
        partySizeLbl.text = "Party Size: 1"
    }
    
    func processCalcBtn(value: String) {
        switch value {
        case "C":
            totalStr = ""
        case "<-":
            totalStr = String(totalStr.dropLast())
        default:
            totalStr.append(value)
            print("All other cases")
        }
        
        print(totalStr)
    }
    
    func calculateTotal() {
        if let tempAmount = Double(totalStr) {
            totalAmount = tempAmount / 100
            print("\(totalAmount)")
            let doubleStr = String(format: "%.2f", totalAmount)
            totalAmountLbl.text = "$\(doubleStr)"
        } else {
            totalAmountLbl.text = "$0.00"
        }
    }
    
    func updateTipLabels() {
        firstPercentageLbl.text = String("\(tipPercentages[tipA]*100)%")
        secondPercentageLbl.text = String("\(tipPercentages[tipB]*100)%")
        lastPercentageLbl.text = String("\(tipPercentages[tipC]*100)%")

        // Tip label amounts
        tipAmountA = (tipPercentages[tipA]*totalAmount)
        var doubleStr = String(format: "%.2f", tipAmountA)
        firstTipLbl.text = "$\(doubleStr)"
        tipAmountB = (tipPercentages[tipB]*totalAmount)
        doubleStr = String(format: "%.2f", tipAmountB)
        secondTipLbl.text = "$\(doubleStr)"
        tipAmountC = (tipPercentages[tipC]*totalAmount)
        doubleStr = String(format: "%.2f", tipAmountC)
        lastTipLbl.text = "$\(doubleStr)"
        

        // Total (inc tip) amounts
        var newAmount = (tipAmountA+totalAmount) / partySize
        doubleStr = String(format: "%.2f", newAmount)
        firstTotalLbl.text = "$\(doubleStr)"
        newAmount = (tipAmountB+totalAmount) / partySize
        doubleStr = String(format: "%.2f", newAmount)
        secondTotalLbl.text = "$\(doubleStr)"
        newAmount = (tipAmountC+totalAmount) / partySize
        doubleStr = String(format: "%.2f", newAmount)
        lastTotalLbl.text = "$\(doubleStr)"
        
        if partySize > 1.0 {
            // Tip label amounts
            tipAmountA = (tipPercentages[tipA]*totalAmount) / partySize
            var doubleStr = String(format: "%.2f", tipAmountA)
            firstTipLbl.text = "$\(doubleStr)"
            tipAmountB = (tipPercentages[tipB]*totalAmount) / partySize
            doubleStr = String(format: "%.2f", tipAmountB)
            secondTipLbl.text = "$\(doubleStr)"
            tipAmountC = (tipPercentages[tipC]*totalAmount) / partySize
            doubleStr = String(format: "%.2f", tipAmountC)
            lastTipLbl.text = "$\(doubleStr)"
        }
    }
    
    func updatePartySizeLabel() {
        let size = Int(partySize)
        let partyStr = "Party Size: \(size)"
        partySizeLbl.text = partyStr
    }
    
    // IB-Actions
    @IBAction func calcBtnPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            if let title = button.titleLabel?.text {
                print(title)
                processCalcBtn(value: title)
                calculateTotal()
                updateTipLabels()
            }
        }
    }
    @IBAction func tipSliderChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let currentValue = Int(slider.value)
            print(currentValue)
            tipB = currentValue
            tipA = tipB - 1
            tipC = tipB + 1
            updateTipLabels()
        }
    }
    
    @IBAction func groupSizeSliderChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let currentValue = Int(slider.value)
            partySize = Double(currentValue)
            print(partySize)
            updateTipLabels()
            updatePartySizeLabel()
        }
    }
    
}
