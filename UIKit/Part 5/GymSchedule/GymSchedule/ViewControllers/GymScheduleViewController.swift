//
//  GymScheduleViewController.swift
//  GymSchedule
//
//  Created by Artur Harutyunyan on 20.06.25.
//

import UIKit

protocol TableViewCellDelegate : AnyObject {
    func showAlert(_ message: String)
    func toggleRegistration(for gymClass: GymClass)
}

extension GymScheduleViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return uniqueDates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = uniqueDates[section]
        return weeklySchedule.filter { $0.date == date }.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return uniqueDates[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let date = uniqueDates[indexPath.section]
        let classForDate = weeklySchedule.filter { $0.date == date }
        let gymClass = classForDate[indexPath.row]
        cell.configure(gymClass)
        cell.delegate = self
        return cell
    }
}

extension GymScheduleViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { (action, view, completion) in
            let date = self.uniqueDates[indexPath.section]
            var classesForDate = self.weeklySchedule.filter { $0.date == date }
            let classToDelete = classesForDate[indexPath.row]
            
            if let indexInSchedule = self.weeklySchedule.firstIndex(where: { $0 === classToDelete }) {
                self.weeklySchedule.remove(at: indexInSchedule)
                classesForDate.remove(at: indexPath.row)
                
                if classesForDate.isEmpty {
                    self.uniqueDates.remove(at: indexPath.section)
                    self.tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                    self.tableHeader.dates = self.uniqueDates
                    self.updateUI()
                } else {
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
            
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

class GymScheduleViewController : UIViewController, TableViewCellDelegate {
    var weeklySchedule: [GymClass] = [
        GymClass(className: "HIIT", time: "08:00", date: "23 June 2025", weekday: "Monday", duration: "45m", trainerName: "Eminem", trainerPhoto: "Eminem", isRegistered: false),
        GymClass(className: "Yoga", time: "10:00", date: "23 June 2025", weekday: "Monday", duration: "60m", trainerName: "Franz Hermann", trainerPhoto: "Franz", isRegistered: false),
        GymClass(className: "Spinning", time: "09:00", date: "24 June 2025", weekday: "Tuesday", duration: "50m", trainerName: "Kanye West", trainerPhoto: "Ye", isRegistered: false),
        GymClass(className: "Crossfit", time: "07:30", date: "25 June 2025", weekday: "Wednesday", duration: "55m", trainerName: "Max Verstappen", trainerPhoto: "Max", isRegistered: false),
        GymClass(className: "Pilates", time: "11:00", date: "25 June 2025", weekday: "Wednesday", duration: "60m", trainerName: "Franz Hermann", trainerPhoto: "Franz", isRegistered: false),
        GymClass(className: "Zumba", time: "18:00", date: "25 June 2025", weekday: "Wednesday", duration: "45m", trainerName: "Eminem", trainerPhoto: "Eminem", isRegistered: false),
        GymClass(className: "Boxing", time: "08:30", date: "26 June 2025", weekday: "Thursday", duration: "40m", trainerName: "Kanye West", trainerPhoto: "Ye", isRegistered: false),
        GymClass(className: "Stretching", time: "12:00", date: "26 June 2025", weekday: "Thursday", duration: "30m", trainerName: "Franz Hermann", trainerPhoto: "Franz", isRegistered: false),
        GymClass(className: "Kickboxing", time: "10:30", date: "27 June 2025", weekday: "Friday", duration: "45m", trainerName: "Max Verstappen", trainerPhoto: "Max", isRegistered: false),
        GymClass(className: "TRX", time: "09:00", date: "28 June 2025", weekday: "Saturday", duration: "50m", trainerName: "Eminem", trainerPhoto: "Eminem", isRegistered: false),
        GymClass(className: "Barre", time: "11:30", date: "28 June 2025", weekday: "Saturday", duration: "55m", trainerName: "Kanye West", trainerPhoto: "Ye", isRegistered: false),
        GymClass(className: "Functional", time: "10:00", date: "29 June 2025", weekday: "Sunday", duration: "60m", trainerName: "Franz Hermann", trainerPhoto: "Franz", isRegistered: false),
        GymClass(className: "Mobility", time: "13:00", date: "29 June 2025", weekday: "Sunday", duration: "45m", trainerName: "Max Verstappen", trainerPhoto: "Max", isRegistered: false),
        GymClass(className: "Dance", time: "17:00", date: "29 June 2025", weekday: "Sunday", duration: "50m", trainerName: "Eminem", trainerPhoto: "Eminem", isRegistered: false)
    ]
    var uniqueDates: [String] = []
    
    private let tableView = UITableView()
    private var emptyViewImage: UIImageView?
    private var emptyViewLabel: UILabel?
    
    private let tableHeader = TableViewHeader(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        extractUniqueDates()
        setupEmptyView()
        setupTableView()
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableHeader.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100)
        tableHeader.dates = uniqueDates
        tableView.tableHeaderView = tableHeader
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupEmptyView() {
        guard emptyViewImage == nil, emptyViewLabel == nil else { return }
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        let label = UILabel()
        label.text = "No classes found"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -40),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        emptyViewImage = imageView
        emptyViewLabel = label
        emptyViewImage?.isHidden = true
        emptyViewLabel?.isHidden = true
    }
    
    
    private func extractUniqueDates() {
        let datesSet = Set(weeklySchedule.map { $0.date })
        uniqueDates = Array(datesSet).sorted()
    }
    
    func toggleRegistration(for gymClass: GymClass) {
        if let index = weeklySchedule.firstIndex(where: { $0 === gymClass }) {
            weeklySchedule[index].isRegistered.toggle()
            
            let message = weeklySchedule[index].isRegistered
            ? "You have registered to \(gymClass.className), see you there!"
            : "You have just cancelled \(gymClass.className) :("
            
            showAlert(message)
            tableView.reloadData()
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Update", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
    
    private func updateUI() {
        let hasData = !weeklySchedule.isEmpty
        
        tableView.isHidden = !hasData
        emptyViewImage?.isHidden = hasData
        emptyViewLabel?.isHidden = hasData
        
        if hasData {
            extractUniqueDates()
            tableHeader.dates = uniqueDates
            tableView.reloadData()
        }
    }
}

#Preview() {
    GymScheduleViewController()
}
