//
//  TravelCardViewController.swift
//  SunriseTravel
//
//  Created by user262355 on 7/29/24.
//
import UIKit
import Foundation

class TravelCardView: UIView {
    let buttonView = UIButton()
    let infoContainerView = UIView()
    let locationLabel = UILabel()
    let countryLabel = UILabel()
    let countryFlag = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        style()
        layout()
        setupActions()
    }
    
    func setup(with data: TravelCardData) {
        locationLabel.text = data.name
        countryLabel.text = data.country
        if let image = UIImage(named: data.heroPicture) {
            buttonView.setImage(image, for: .normal)
            buttonView.imageView?.layer.cornerRadius = 22
            buttonView.imageView?.clipsToBounds = true
        }
        if let image = UIImage(named: data.country) {
            countryFlag.image = image
        }
    }
}

extension TravelCardView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.layer.borderColor = UIColor.systemGray4.cgColor
        buttonView.layer.borderWidth = 5
        buttonView.layer.cornerRadius = 22
        
        // Enable shadow
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowOffset = CGSize(width: 5, height: 5)
        buttonView.layer.shadowOpacity = 0.5
        buttonView.layer.shadowRadius = 5
        
        // Style the container view
        infoContainerView.translatesAutoresizingMaskIntoConstraints = false
        infoContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        infoContainerView.layer.cornerRadius = 8
        infoContainerView.isUserInteractionEnabled = false
                
        // Style for location label
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        locationLabel.textColor = .black
                
        // Style for country label
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.font = UIFont.systemFont(ofSize: 16)
        countryLabel.textColor = .black
        
        // Image Flag
        countryFlag.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        addSubview(buttonView)
        addSubview(infoContainerView)
        infoContainerView.addSubview(countryFlag)
        infoContainerView.addSubview(locationLabel)
        infoContainerView.addSubview(countryLabel)
        
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 275),
            
            buttonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonView.topAnchor.constraint(equalTo: topAnchor),
            buttonView.heightAnchor.constraint(equalTo: heightAnchor),

            // Info container view constraints
            infoContainerView.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 5),
            infoContainerView.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 5),
            infoContainerView.trailingAnchor.constraint(lessThanOrEqualTo: buttonView.trailingAnchor, constant: -16),
            
            countryFlag.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 8),
            countryFlag.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 18),
            countryFlag.heightAnchor.constraint(equalToConstant: 30),
            countryFlag.widthAnchor.constraint(equalToConstant: 55),
            
            // Location label constraints
            locationLabel.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -8),
            locationLabel.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 8),
            
            // Country label constraints
            countryLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),
            countryLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            countryLabel.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -8)
        ])
    }
    
    func setupActions() {
        buttonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print("Hello, World!")
    }
}
