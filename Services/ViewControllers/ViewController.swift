//
//  ViewController.swift
//  Services
//
//  Created by Alexandr Onischenko on 30.03.2024.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    lazy var services: [Service] = {
        var services = [Service]()
        return services
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        title = "Сервисы"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]

        configureView()
        activityIndicator.startAnimating()
        ServiceRepository.shared.getServices { result in
            switch result {
            case .success(let services):
                self.services = services
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            case .failure(_):
                break
            }
        }
    }

    private func configureView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        let service = services[indexPath.row]
        cell.configureView(service: service)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: services[indexPath.row].link) else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let webViewController = WebViewController(request: URLRequest(url: url))
        navigationController?.pushViewController(webViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
