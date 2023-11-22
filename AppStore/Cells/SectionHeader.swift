//
//  SectionHeader.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto 
//

import UIKit


class SectionHeader: UICollectionReusableView {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
        
    }()
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
        
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [separatorView,
                                                       titleLabel,
                                                       subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionHeader: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    func addConstraints() {
        separatorView.constrainHeight(1)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 0,
                                                      left: 0,
                                                      bottom: 10,
                                                      right: 0))
        stackView.setCustomSpacing(10, after: separatorView)
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct SectionHeaderViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            UIViewPreview {
                let header = SectionHeader()
                header.titleLabel.text = "Lorem ipsum"
                header.subtitleLabel.text = "Lorem ipsum"
                
                return header
            }
            .previewLayout(.fixed(width: UIScreen.main.bounds.width,
                                  height: 80))
        }
        UIViewPreview {
            let header = SectionHeader()
            header.titleLabel.text = "Lorem ipsum"
            return header
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width,
                              height: 80))
    }
}

#endif
