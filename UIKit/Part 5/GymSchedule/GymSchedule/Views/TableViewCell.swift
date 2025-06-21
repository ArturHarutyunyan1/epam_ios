//
//  TableViewCell.swift
//  GymSchedule
//
//  Created by Artur Harutyunyan on 21.06.25.
//

import UIKit

class TableViewCell : UITableViewCell {
    weak var delegate: TableViewCellDelegate?
    private var gymClass: GymClass?
    
    private let trainerImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let className: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 20, weight: .bold)
        name.textColor = .label
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private let trainerName: UILabel = {
        let name = UILabel()
        name.textColor = .secondaryLabel
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private let time: UILabel = {
        let time = UILabel()
        time.textColor = .secondaryLabel
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    private let duration: UILabel = {
        let duration = UILabel()
        duration.textColor = .secondaryLabel
        duration.translatesAutoresizingMaskIntoConstraints = false
        return duration
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        registerButton.addTarget(self, action: #selector(registerToClass), for: .touchUpInside)
    }
    
    func configure(_ gymClass: GymClass) {
        self.gymClass = gymClass
        trainerImageView.image = UIImage(named: gymClass.trainerPhoto) ?? UIImage(systemName: "person.circle")
        className.text = "\(gymClass.className)"
        trainerName.text = "\(gymClass.trainerName)"
        time.text = "\(gymClass.time)"
        duration.text = " • \(gymClass.duration)"
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let plusIcon = UIImage(systemName: "plus", withConfiguration: config)
        let xIcon = UIImage(systemName: "xmark", withConfiguration: config)
        
        if gymClass.isRegistered {
            registerButton.setImage(xIcon, for: .normal)
            registerButton.tintColor = .white
            registerButton.backgroundColor = .systemRed
        } else {
            registerButton.setImage(plusIcon, for: .normal)
            registerButton.tintColor = .white
            registerButton.backgroundColor = .systemGreen
        }
    }
    
    private func setupViews() {
        [trainerImageView, className, trainerName, time, duration].forEach {
            self.addSubview($0)
        }
        self.contentView.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            trainerImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            trainerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            trainerImageView.widthAnchor.constraint(equalToConstant: 60),
            trainerImageView.heightAnchor.constraint(equalToConstant: 60),
            trainerImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -25),
            
            className.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            className.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: 10),
            
            trainerName.topAnchor.constraint(equalTo: className.bottomAnchor, constant: 1),
            trainerName.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: 10),
            
            time.topAnchor.constraint(equalTo: trainerName.bottomAnchor, constant: 1),
            time.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: 10),
            
            duration.topAnchor.constraint(equalTo: trainerName.bottomAnchor, constant: 1),
            duration.leadingAnchor.constraint(equalTo: time.trailingAnchor),
            
            registerButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            registerButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            registerButton.widthAnchor.constraint(equalToConstant: 60),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -25)
        ])
    }
    
    @objc private func registerToClass(_ sender: UIButton) {
        if let gymClass = gymClass {
            delegate?.toggleRegistration(for: gymClass)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
