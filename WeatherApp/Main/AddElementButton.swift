import UIKit

class AddElementButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame.size.width = 40
        self.frame.size.height = 40
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.addSubview(image)
        setConstraints()
    }
    
    var image : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "plus")
        view.contentMode = .scaleAspectFit
        view.frame.size.width = 30
        view.frame.size.height = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setConstraints() {
        let imageLeftConstraint = NSLayoutConstraint(item: image, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10)
        let imageRightConstraint = NSLayoutConstraint(item: image, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10)
        let imageCenterYConstraint = NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let imageCenterXConstraint = NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        

        NSLayoutConstraint.activate([
            imageLeftConstraint, imageRightConstraint,
            imageCenterYConstraint, imageCenterXConstraint
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
