import UIKit

class TipsViewController: UIViewController {
    var tipsData: [TipsData] = []
    let scrollview = UIScrollView()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        if let data = loadJSONTips() {
            setupTips(with: data)
        }
    }
}

extension TipsViewController {
    func style() {
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
    }
    
    func layout(){
        scrollview.addSubview(stackView)
        view.addSubview(scrollview)
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            scrollview.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollview.trailingAnchor, multiplier: 1),
            scrollview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollview.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollview.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollview.widthAnchor)
        ])
    }
    
    func setupTips(with tipsData: [TipsData]) {
        for data in tipsData {
            let tip = TipView()
            tip.setup(with: data)
            stackView.addArrangedSubview(tip)
        }
    }
}
