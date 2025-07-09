//
//  DocumentIOViewController.swift
//  SaveAndRetrieveFiles
//
//  Created by Artur Harutyunyan on 09.07.25.
//

import UIKit


class DocumentIOViewController: UIViewController {
    private let mainStack = UIStackView()
    private let textView = UITextView()
    private let fileContent = UILabel()
    private let scrollView = UIScrollView()
    private let buttonStack = UIStackView()
    private let saveButton = UIButton(type: .system)
    private let loadButton = UIButton(type: .system)
    private let spacer = UIView()
    private let fileName = "userTextFile"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        mainStack.isLayoutMarginsRelativeArrangement = true
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        mainStack.addArrangedSubview(textView)
        setupButtons()
        setupScrollView()
    }
    
    private func setupButtons() {
        buttonStack.axis = .horizontal
        buttonStack.spacing = 16
        buttonStack.distribution = .fillEqually
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        loadButton.setTitle("Load", for: .normal)
        loadButton.backgroundColor = .systemGreen
        loadButton.setTitleColor(.white, for: .normal)
        loadButton.layer.cornerRadius = 10
        loadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        
        buttonStack.addArrangedSubview(saveButton)
        buttonStack.addArrangedSubview(loadButton)
        mainStack.addArrangedSubview(buttonStack)
        mainStack.addArrangedSubview(spacer)
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.setContentHuggingPriority(.defaultLow, for: .vertical)
        scrollView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        scrollView.isHidden = true
        mainStack.addArrangedSubview(scrollView)
        
        fileContent.translatesAutoresizingMaskIntoConstraints = false
        fileContent.numberOfLines = 0
        fileContent.font = .systemFont(ofSize: 25)
        scrollView.addSubview(fileContent)
        
        NSLayoutConstraint.activate([
            fileContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            fileContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            fileContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            fileContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            fileContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    @objc private func saveButtonTapped() {
        createFile()
    }
    
    @objc private func loadButtonTapped() {
        readFile()
        mainStack.removeArrangedSubview(spacer)
        spacer.removeFromSuperview()
        scrollView.isHidden = false
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}

private extension DocumentIOViewController {
    func createFile() {
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            self.showAlert("Cannot find Documents directory")
            return
        }
        let userTextFile = documentsURL.appendingPathComponent(fileName)
        guard let content = textView.text, !content.isEmpty else {
            self.showAlert("Can't create file with empty content")
            return
        }
        guard let data = content.data(using: .utf8) else {
            self.showAlert("Content cannot be converted into UTF-8 format")
            return
        }
        do {
            try data.write(to: userTextFile, options: .completeFileProtection)
            self.showAlert("File was saved successfully")
        } catch {
            self.showAlert("Error while creating file: \(error.localizedDescription)")
        }
    }
    
    func readFile(){
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            self.showAlert("Cannot find Documents directory")
            return
        }
        let userTextFile = documentsURL.appendingPathComponent(fileName)
        do {
            let readData = try Data(contentsOf: userTextFile)
            if let readString = String(data: readData, encoding: .utf8) {
                self.fileContent.text = readString
            } else {
                self.showAlert("Cannot decode data as UTF-8 string")
            }
        } catch {
            self.showAlert("Error reading file: \(error.localizedDescription)")
        }
    }
}

#Preview {
    DocumentIOViewController()
}
