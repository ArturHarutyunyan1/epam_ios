//
//  TableViewHeader.swift
//  GymSchedule
//
//  Created by Artur Harutyunyan on 21.06.25.
//

import UIKit

class TableViewHeader : UIView {
    var dates: [String] = [] {
        didSet {
            scrollView.subviews.forEach { $0.removeFromSuperview() }
            addDays()
        }
    }
    
    private let scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScrollView()
    }
    
    private func setupScrollView() {
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    private func addDays() {
        var prev: UIView? = nil
        for i in 0..<dates.count {
            let dateView = UIView()
            dateView.backgroundColor = UIColor.systemGray6
            dateView.layer.cornerRadius = 12
            dateView.translatesAutoresizingMaskIntoConstraints = false
            
            let day = UILabel()
            day.text = String(dates[i].prefix(2))
            day.font = .systemFont(ofSize: 18, weight: .semibold)
            day.textColor = .label
            day.textAlignment = .center
            
            let weekday = UILabel()
            weekday.text = weekdayName(from: dates[i])
            weekday.font = .systemFont(ofSize: 14, weight: .regular)
            weekday.textColor = .secondaryLabel
            weekday.textAlignment = .center
            
            let stack = UIStackView(arrangedSubviews: [day, weekday])
            stack.axis = .vertical
            stack.alignment = .center
            stack.spacing = 2
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            dateView.addSubview(stack)
            scrollView.addSubview(dateView)
            
            NSLayoutConstraint.activate([
                dateView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                dateView.heightAnchor.constraint(equalToConstant: 60),
                dateView.widthAnchor.constraint(equalToConstant: 60),
                
                stack.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
                stack.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
            ])
            
            if let last = prev {
                dateView.leadingAnchor.constraint(equalTo: last.trailingAnchor, constant: 20).isActive = true
            } else {
                dateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
            }
            prev = dateView
        }
        prev?.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func weekdayName(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = formatter.date(from: dateString) else { return "" }
        
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEE"
        weekdayFormatter.locale = Locale(identifier: "en_US_POSIX")
        return weekdayFormatter.string(from: date)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
