//
//  ViewController.swift
//  SunriseTravel
//
//  Created by user262355 on 7/29/24.
//
import UIKit

class ViewController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var travelData: [TravelCardData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        if let data = loadJSONData() {
            setupTravelCards(with: data)
        }
    }
    
    func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 2),
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 5),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 2),
            
            // Set stackView edges to scrollView content layout guide
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            // Make stackView width equal to scrollView frame layout guide width
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    func setupTravelCards(with travelData: [TravelCardData]) {
        for data in travelData {
            let travelCard = TravelCardView()
            travelCard.setup(with: data)
            stackView.addArrangedSubview(travelCard)
        }
    }
}
