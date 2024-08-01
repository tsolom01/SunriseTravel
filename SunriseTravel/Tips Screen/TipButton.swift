//
//  TipButton.swift
//  SunriseTravel
//
//  Created by user262355 on 8/1/24.
//

import Foundation
import UIKit

class TipButton: UIButton {
    private let iconImageView = UIImageView()
    private let chevronImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        style()
        layout()
    }
    
}

extension TipButton {
    
    func style() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.image = UIImage(systemName: "chevron.down")
        
        setTitleColor(.black, for: .normal)
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    func layout() {
        addSubview(iconImageView)
        addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 200),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            
            chevronImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            chevronImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 30),
            chevronImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with title: String, iconImage icon: String) {
        iconImageView.image = UIImage(named: icon)
        setTitle(title, for: .normal)
        titleLabel?.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel?.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -10).isActive = true
    }
    
    func toggleChevron(up: Bool) {
        let imageName = up ? "chevron.up" : "chevron.down"
        chevronImageView.image = UIImage(systemName: imageName)
    }
}
