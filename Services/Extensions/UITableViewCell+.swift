//
//  UITableViewCell+.swift
//  Services
//
//  Created by Alexandr Onischenko on 30.03.2024.
//

import Foundation
import UIKit

extension UITableViewCell {
    func configureView(service: Service) {
        accessoryType = .disclosureIndicator
        let url = URL(string: service.iconURL)
        let imageView = UIImageView()
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "photo")
        )

        var content = UIListContentConfiguration.sidebarCell()
        content.imageProperties.maximumSize = CGSize(width: 64, height: 64)
        content.imageToTextPadding = 16
        content.imageProperties.cornerRadius = 4
        content.secondaryTextProperties.font = .systemFont(ofSize: 16, weight: .light)

        content.image = imageView.image
        content.secondaryText = service.description
        content.secondaryTextProperties.numberOfLines = 0

        content.text = "\(service.name)"
        contentConfiguration = content
    }
}
