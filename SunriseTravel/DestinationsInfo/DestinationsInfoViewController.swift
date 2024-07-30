//
//  DestinationsInfoViewController.swift
//  SunriseTravel
//
//  Created by user262355 on 7/30/24.
//

import Foundation
import UIKit

class DestinationsInfoViewController: UIViewController {
    var data: TravelCardData?
    
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    
    let locationLabel = UILabel()
    let countryView = UIStackView()
    let countryFlagView = UIImageView()
    let countryLabel = UILabel()
    let viewMapButton = UIButton(type: .system)
    
    let carouselView = UIView()
    let leftArrowImageView = UIImageView()
    let rightArrowImageView = UIImageView()
    let imageView = UIImageView()
    
    
    let descriptionLabel = UILabel()
    let learnMoreButton = UIButton()
    let learnMoreLabel = UILabel()
    let advisoryLabel = UILabel()
    let bookButton = UIButton()
    
    var currentImageIndex = 0
    var advisoryLabelTopConstraint: NSLayoutConstraint?
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
        setupGestureRecognizers()
    }
    
    func setup() {
        guard let data = data else { return }
        locationLabel.text = data.name
        label.text = data.name
        if let image = UIImage(named: data.country) {
            countryFlagView.image = image
        }
        countryLabel.text = data.country
        updateImage()
        descriptionLabel.text = data.description
        learnMoreLabel.text = data.more
        advisoryLabel.text = data.advisory
    }
    
    func setupGestureRecognizers() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        carouselView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        carouselView.addGestureRecognizer(swipeRight)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        carouselView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            nextImage()
        } else if gesture.direction == .right {
            previousImage()
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: carouselView)
        let halfWidth = carouselView.bounds.width / 2
        
        if location.x < halfWidth {
            previousImage()
        } else {
            nextImage()
        }
    }
    
    @objc func nextImage() {
        guard let data = data else { return }
        currentImageIndex = (currentImageIndex + 1) % data.pictures.count
        updateImage()
    }
    
    @objc func previousImage() {
        guard let data = data else { return }
        currentImageIndex = (currentImageIndex - 1 + data.pictures.count) % data.pictures.count
        updateImage()
    }
    
    func updateImage() {
            guard let data = data else { return }
            let imageName = data.pictures[currentImageIndex]
            let newImage = UIImage(named: imageName)
            
            UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.imageView.image = newImage
            }, completion: nil)
        }
}

extension DestinationsInfoViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        locationLabel.numberOfLines = 0
        
        countryView.translatesAutoresizingMaskIntoConstraints = false
        countryView.axis = .horizontal
        countryView.spacing = 10
        
        countryLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        countryLabel.numberOfLines = 0
        
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.clipsToBounds = true
        carouselView.layer.cornerRadius = 10
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        leftArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        leftArrowImageView.image = UIImage(systemName: "arrow.left")
        leftArrowImageView.tintColor = .white
        leftArrowImageView.contentMode = .scaleAspectFit
        
        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        rightArrowImageView.image = UIImage(systemName: "arrow.right")
        rightArrowImageView.tintColor = .white
        rightArrowImageView.contentMode = .scaleAspectFit
        
        var config = UIButton.Configuration.filled()
        config.title = "View on map"
        config.image = UIImage(systemName: "mappin.and.ellipse")?.withRenderingMode(.alwaysTemplate)
        config.imagePlacement = .leading
        config.cornerStyle = .medium
        config.imagePadding = 8
        config.baseForegroundColor = .systemBlue
        config.baseBackgroundColor = .secondarySystemFill
        viewMapButton.configuration = config
        viewMapButton.titleLabel?.numberOfLines = 0
        viewMapButton.titleLabel?.textAlignment = .center
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified
        
        learnMoreButton.translatesAutoresizingMaskIntoConstraints = false
        learnMoreButton.setTitle("I want to learn more!!!", for: .normal)
        learnMoreButton.setTitleColor(.systemBlue, for: .normal)
        learnMoreButton.backgroundColor = .clear
        learnMoreButton.addTarget(self, action: #selector(showMoreInfoTapped), for: .touchUpInside)
        
        learnMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        learnMoreLabel.font = UIFont.preferredFont(forTextStyle: .body)
        learnMoreLabel.numberOfLines = 0
        learnMoreLabel.textAlignment = .justified
        learnMoreLabel.isHidden = true
        
        advisoryLabel.translatesAutoresizingMaskIntoConstraints = false
        advisoryLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        advisoryLabel.textColor = .systemRed
        advisoryLabel.textAlignment = .center
        advisoryLabel.numberOfLines = 0
        
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        bookButton.setTitle("Book Now", for: .normal)
        bookButton.backgroundColor = .systemBlue
    }
    
    func layout() {
        countryView.addArrangedSubview(countryFlagView)
        countryView.addArrangedSubview(countryLabel)
        countryView.addArrangedSubview(viewMapButton)
        
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(countryView)
        carouselView.addSubview(imageView)
        carouselView.addSubview(leftArrowImageView)
        carouselView.addSubview(rightArrowImageView)
        stackView.addArrangedSubview(carouselView)
        
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(learnMoreButton)
        scrollView.addSubview(learnMoreLabel)
        scrollView.addSubview(advisoryLabel)
        stackView.addArrangedSubview(scrollView)
        stackView.addArrangedSubview(bookButton)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
            
            locationLabel.heightAnchor.constraint(equalToConstant: 50),
            
            countryView.heightAnchor.constraint(equalToConstant: 40),
            countryFlagView.widthAnchor.constraint(equalToConstant: 65),
            
            carouselView.heightAnchor.constraint(equalToConstant: 200),
            imageView.leadingAnchor.constraint(equalTo: carouselView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: carouselView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: carouselView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: carouselView.bottomAnchor),
            
            leftArrowImageView.leadingAnchor.constraint(equalTo: carouselView.leadingAnchor, constant: 10),
            leftArrowImageView.centerYAnchor.constraint(equalTo: carouselView.centerYAnchor),
            leftArrowImageView.widthAnchor.constraint(equalToConstant: 24),
            leftArrowImageView.heightAnchor.constraint(equalToConstant: 24),
            
            rightArrowImageView.trailingAnchor.constraint(equalTo: carouselView.trailingAnchor, constant: -10),
            rightArrowImageView.centerYAnchor.constraint(equalTo: carouselView.centerYAnchor),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: 24),
            rightArrowImageView.heightAnchor.constraint(equalToConstant: 24),
            
            scrollView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            // Ensure scrollView height is determined by its content
            scrollView.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: bookButton.topAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            learnMoreButton.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 1),
            learnMoreButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            
            learnMoreLabel.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 1),
            learnMoreLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            learnMoreLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            advisoryLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            advisoryLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            advisoryLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        advisoryLabelTopConstraint = advisoryLabel.topAnchor.constraint(equalToSystemSpacingBelow: learnMoreButton.bottomAnchor, multiplier: 1)
        advisoryLabelTopConstraint?.isActive = true
    }
    
    @objc func showMoreInfoTapped() {
        learnMoreLabel.isHidden = false
        learnMoreButton.isHidden = true
        advisoryLabelTopConstraint?.isActive = false
            
            advisoryLabelTopConstraint = advisoryLabel.topAnchor.constraint(equalToSystemSpacingBelow: learnMoreLabel.bottomAnchor, multiplier: 1)
            
            // Activate the new constraint
            advisoryLabelTopConstraint?.isActive = true
            
            // Optionally, update the scroll view layout
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
    }
}
