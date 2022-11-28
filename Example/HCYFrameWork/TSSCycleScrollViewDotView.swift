

import UIKit

class TSSDotView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    private func configUI() {
        backgroundColor = .clear
        layer.cornerRadius = frame.width / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
}

extension TSSDotView: DotViewDelegate {
    func changeActivityState(active: Bool) {
        backgroundColor = active ? .white : .clear
    }
}

class TSSAnimateDotView: UIView {
    var currentDotColor: UIColor = .white
    var dotColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    private func configUI() {
        backgroundColor = .clear
        layer.cornerRadius = frame.width / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
}

extension TSSAnimateDotView: DotViewDelegate {
    func changeActivityState(active: Bool) {
        active ? animateToActiveState() : animateToDeactiveState()
    }
    
    func animateToActiveState() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: -20, options: .curveLinear, animations: {
            self.backgroundColor = self.currentDotColor
            self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }, completion: nil)
    }
    
    func animateToDeactiveState() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.backgroundColor = self.dotColor
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
