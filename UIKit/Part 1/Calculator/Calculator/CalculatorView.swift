//
//  CalculatorView.swift
//  Calculator
//
//  Created by Artur Harutyunyan on 09.06.25.
//

import UIKit

class CalculatorView: UIView {
    private let calculatorButtons = [
        "7", "8", "9", "÷",
        "4", "5", "6", "×",
        "1", "2", "3", "-",
        "C", "0", "=", "+"
    ]
    private let displayContainer = UIView()
    private let displayText = UILabel()
    private var buttons = [UIButton]()
    private let buttonsContainer = UIView()
    
    private func setupDisplay() {
        displayText.text = "0"
        displayText.textColor = .white
        displayText.textAlignment = .right
        displayText.adjustsFontSizeToFitWidth = true
        displayText.minimumScaleFactor = 0.5
        displayText.numberOfLines = 1
        displayText.font = .systemFont(ofSize: 36, weight: .bold)
        displayContainer.addSubview(displayText)
    }
    
    private func setupButtons() {
        for title in calculatorButtons {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tintColor = .white
            button.titleLabel?.font = .systemFont(ofSize: 42)
            buttonsContainer.addSubview(button)
            buttons.append(button)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(displayContainer)
        addSubview(buttonsContainer)
        setupDisplay()
        setupButtons()
    }
    
    override func layoutSubviews() {
        displayContainer.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height * 0.5
        )
        
        displayText.frame = CGRect(
            x: 0,
            y: safeAreaInsets.top + 50,
            width: displayContainer.bounds.width - 10,
            height: 50
        )
        
        buttonsContainer.frame = CGRect(
            x: 0,
            y: bounds.height - bounds.height * 0.5,
            width: bounds.width,
            height: bounds.height * 0.5
        )
        
        let cols = 4
        let rows = 4
        
        let totalHorizontalSpacing: CGFloat = 16 * CGFloat(cols + 1)
        let totalVerticalSpacing: CGFloat = 16 * CGFloat(rows + 1)
        
        let availableWidth = buttonsContainer.bounds.width - totalHorizontalSpacing
        let availableHeight = buttonsContainer.bounds.height - totalVerticalSpacing
        
        let buttonWidth = availableWidth / CGFloat(cols)
        let buttonHeight = availableHeight / CGFloat(rows)
        
        let buttonSize = min(buttonWidth, buttonHeight)
        
        let totalButtonHeight = CGFloat(rows) * buttonSize + CGFloat(rows + 1) * 16
        let startY = buttonsContainer.bounds.height - totalButtonHeight
        
        for (index, button) in buttons.enumerated() {
            let row = index / cols
            let col = index % cols
            
            let x = 16 + CGFloat(col) * (buttonSize + 16)
            let y = startY + 16 + CGFloat(row) * (buttonSize + 16)
            
            button.frame = CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
            button.layer.cornerRadius = buttonSize / 2
            styleButtons(button)
            button.addTarget(self, action: #selector(handlePress), for: .touchUpInside)
        }
    }
    
    private func styleButtons(_ button: UIButton) {
        if let title = button.currentTitle {
            if title >= "0" && title <= "9" {
                button.backgroundColor = .systemGray2
            } else {
                button.backgroundColor = .systemOrange
            }
        }
    }
    
    @objc private func handlePress(_ sender: UIButton) {
        if let value = displayText.text {
            if let title = sender.currentTitle {
                handleInput(title, value)
            }
        }
    }
    
    private func handleInput(_ title: String, _ value: String) {
        switch title {
        case "C":
            if value == "Can't divide by zero" || value == "Error"{
                displayText.text = "0"
            }
            if value != "0" && !value.isEmpty {
                displayText.text?.removeLast()
            }
            if displayText.text?.isEmpty ?? true {
                displayText.text = "0"
            }
        case "+", "-", "×", "÷":
            if let last = value.last {
                if last.isNumber {
                    displayText.text?.append(title)
                } else if ["+", "-", "×", "÷"].contains(last) {
                    displayText.text?.removeLast()
                    displayText.text?.append(title)
                }
            }
        case "=":
            if let last = value.last, last.isNumber {
                evaluateExpression(value)
            }
        default:
            if title >= "0" && title <= "9" {
                if value == "0" || value == "Can't divide by zero" || value == "Error" {
                    displayText.text = title
                } else {
                    displayText.text?.append(title)
                }
            } else {
                print("Unexpected error")
            }
        }
    }
    
    private func evaluateExpression(_ expression: String) {
        let base = expression
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
        let pattern = #"(?<![\d.])(\d+)(?![\d.])"#
        let expr = base.replacingOccurrences(
            of: pattern,
            with: "$1.0",
            options: .regularExpression
        )
        if expr.contains("/0") {
            displayText.text = "Can't divide by zero"
            return
        }
        let exp = NSExpression(format: expr)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            displayText.text = result.stringValue
        } else {
            displayText.text = "Error"
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("Init coder failed")
    }
}
