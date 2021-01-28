import UIKit

final class AddElementButton: UIButton {

    private struct Constants {
        static let imageSize: CGFloat = 30
        static let buttonImage: UIImage = UIImage(systemName: "plus") ?? UIImage()
        static let buttonSize: CGFloat = 40
        static let buttonBorderWidth: CGFloat = 1
        static let buttonHighlightedColor: UIColor = .lightGray
    }
    
    // MARK: — Private Properties
    private var image : UIImageView = {
        let view = UIImageView()
        view.image = Constants.buttonImage
        view.contentMode = .scaleAspectFit
        view.frame.size.width = Constants.imageSize
        view.frame.size.height = Constants.imageSize
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override var isHighlighted: Bool {
            get {
                return super.isHighlighted
            }
            set {
                if newValue {
                    backgroundColor = Constants.buttonHighlightedColor
                }
                else {
                    backgroundColor = .none
                }
                super.isHighlighted = newValue
            }
        }
    
    // MARK: — Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame.size.width = Constants.buttonSize
        self.frame.size.height = Constants.buttonSize
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = Constants.buttonBorderWidth
        self.addSubview(image)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: — Private Methods
    private func setConstraints() {
        let imageLeftConstraint = NSLayoutConstraint(item: image, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10)
        let imageRightConstraint = NSLayoutConstraint(item: image, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10)
        let imageCenterYConstraint = NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let imageCenterXConstraint = NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)

        NSLayoutConstraint.activate([
            imageLeftConstraint, imageRightConstraint,
            imageCenterYConstraint, imageCenterXConstraint
        ])
    }
}
