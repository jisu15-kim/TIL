import UIKit

class QnAViewDetailCell: UICollectionViewCell {
    var data: QnARecommandModel?
    
    var viewA: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewB: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var hashMark: UILabel = {
        let label = UILabel()
        label.text = "#"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stack: UIStackView?
    
    func setupUI() {
        self.stack = UIStackView(arrangedSubviews: [viewA, hashMark, titleLabel, viewB])
        self.stack?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack!)
        setupConstraint()
        self.backgroundColor = .systemGray6
    }
    
    func setupConstraint() {
        guard let stack = self.stack else { return }
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.heightAnchor.constraint(equalToConstant: 20),
            
            viewA.widthAnchor.constraint(equalToConstant: 5),
            viewB.widthAnchor.constraint(equalToConstant: 15),
            hashMark.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func configure() {
        titleLabel.text = data?.title
    }
}
