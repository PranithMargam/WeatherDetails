//
//  LocationCell.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import UIKit

class LocationCell: UITableViewCell {
    static let cellId = "CellId"
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpTitleLabel()
        addBottomLine()
        addForwardImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData(location: Location) {
        self.nameLabel.text = location.name
    }
    
    private func setUpTitleLabel() {
        self.contentView.addSubview(nameLabel)
        nameLabel.anchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: self.contentView.trailingAnchor,padding: UIEdgeInsets.init(top: 12, left: 24, bottom: 4, right: 0))
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
    }
    
    private func addBottomLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        self.contentView.addSubview(bottomLine)
        bottomLine.anchor(top: nil, leading: self.contentView.leadingAnchor, bottom: self.contentView.bottomAnchor, trailing: self.contentView.trailingAnchor, padding: .zero, size: CGSize(width: 0, height: 0.5))
    }
    
    private func addForwardImageView() {
        let forwardImagView = UIImageView()
        forwardImagView.image = UIImage(systemName: "chevron.forward")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        forwardImagView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(forwardImagView)
        NSLayoutConstraint.activate([
            forwardImagView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor,constant: 0),
            forwardImagView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -24),
            forwardImagView.heightAnchor.constraint(equalToConstant: 24),
            forwardImagView.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
}
