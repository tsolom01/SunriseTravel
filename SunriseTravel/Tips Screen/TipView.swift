import UIKit

class TipView: UIView {
    let toggleButton = TipButton(type: .system)
    let detailsLabel = UILabel()
    var isExpanded: Bool = false
    var detailsLabelHeightConstraint: NSLayoutConstraint?
    
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

extension TipView {
    func style() {
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.layer.borderColor = UIColor.black.cgColor
        toggleButton.layer.borderWidth = 2.0
        toggleButton.layer.cornerRadius = 8
        toggleButton.clipsToBounds = true
        toggleButton.addTarget(self, action: #selector(toggleExpansion), for: .touchUpInside)
        
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.numberOfLines = 0
        detailsLabel.isHidden = true
        
        updateDetailsLabelVisibility()
    }

    func layout() {
        addSubview(toggleButton)
        addSubview(detailsLabel)
        
        NSLayoutConstraint.activate([
            toggleButton.topAnchor.constraint(equalTo: topAnchor),
            toggleButton.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            toggleButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            toggleButton.heightAnchor.constraint(equalToConstant: 60),
            
            detailsLabel.topAnchor.constraint(equalTo: toggleButton.bottomAnchor, constant: 8),
            detailsLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: toggleButton.leadingAnchor, multiplier: 2),
            detailsLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: detailsLabel.trailingAnchor, multiplier: 3)
        ])
        
        detailsLabelHeightConstraint = detailsLabel.heightAnchor.constraint(equalToConstant: 0)
        detailsLabelHeightConstraint?.isActive = true
    }

    private func updateButton() {
        toggleButton.toggleChevron(up: isExpanded)
    }

    private func updateDetailsLabelVisibility() {
        detailsLabel.isHidden = !isExpanded
        detailsLabelHeightConstraint?.isActive = !isExpanded
        if isExpanded {
            detailsLabelHeightConstraint?.constant = detailsLabel.intrinsicContentSize.height
        } else {
            detailsLabelHeightConstraint?.constant = 0
        }
    }

    @objc private func toggleExpansion() {
        isExpanded.toggle()
        updateButton()
        
        detailsLabel.isHidden = !isExpanded
        detailsLabelHeightConstraint?.isActive = !isExpanded
        
        // Only update layout if there is a change
        if isExpanded {
            detailsLabelHeightConstraint?.constant = detailsLabel.intrinsicContentSize.height
        } else {
            detailsLabelHeightConstraint?.constant = 0
        }
        
        // Animate the layout changes smoothly
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        })
    }

    func setup(with data: TipsData) {
        toggleButton.setTitle(data.text, for: .normal)
        toggleButton.configure(with: data.text, iconImage: data.icon)
        if let firstDetail = data.children.first {
            detailsLabel.text = firstDetail.text
        }
    }
}
