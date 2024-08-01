//
//  ViewController.swift
//  SunriseTravel
//
//  Created by user262355 on 7/29/24.
//
import UIKit

class ViewController: UIViewController {
    let titleLabel = UILabel()
    let dividerView = UIView()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var travelData: [TravelCardData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        configureNavigationBar()
        if let data = loadJSONLocations() {
            setupTravelCards(with: data)
        }
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.white

        let tipsButton = UIButton(type: .system)
        tipsButton.setImage(UIImage(systemName: "lightbulb")?.withRenderingMode(.alwaysOriginal), for: .normal)
        tipsButton.setTitle(" Tips", for: .normal)
        tipsButton.setTitleColor(.white, for: .normal)
        tipsButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tipsButton.addTarget(self, action: #selector(navigateToTips), for: .touchUpInside)

        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(navigateToTips))
        let tipsBarButtonItem = UIBarButtonItem(customView: tipsButton)
        
        navigationItem.leftBarButtonItem = profileButton
        navigationItem.rightBarButtonItem = tipsBarButtonItem
    }
    
    @objc func navigateToTips() {
        let tipsVC = TipsViewController()
        navigationController?.pushViewController(tipsVC, animated: true)
    }
    
    func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Destinations"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .systemCyan
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(dividerView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 2),
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            dividerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dividerView.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 0),
            dividerView.heightAnchor.constraint(equalToConstant: 3),
            
            // Set stackView edges to scrollView content layout guide
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: dividerView.bottomAnchor, multiplier: 3),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            // Make stackView width equal to scrollView frame layout guide width
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    func setupTravelCards(with travelData: [TravelCardData]) {
        for data in travelData {
            let travelCard = TravelCardView()
            travelCard.setup(with: data)
            travelCard.onButtonTap = { [weak self] in
                self?.navigateToDestinationInfo(with: data)
            }
            
            stackView.addArrangedSubview(travelCard)
        }
    }
    
    func navigateToDestinationInfo(with data: TravelCardData) {
        let destinationVC = DestinationsInfoViewController()
        destinationVC.data = data
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
