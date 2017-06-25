//
//  UIHelper.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Shimmer

class UIHelper: NSObject {
    static func createShimmerBlocks(numberOf count:Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Defines.spacings.singleUnit
        
        for _ in 0..<count {
            let block = self.createAShimmerBlock()
            block.isShimmering = true
            stackView.addArrangedSubview(block)
        }
        
        return stackView
    }
    
    static func createAShimmerBlock() -> FBShimmeringView {
        
        let shimmeringView = FBShimmeringView(frame: CGRect.zero)
        shimmeringView.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = Defines.Colors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        shimmeringView.contentView = view
        return shimmeringView
    }
    
    static func createLabels(from configurations:[UILabelDescriptor]) -> [UILabel] {
        return configurations.map({ (descriptor) -> UILabel in
            let label = UILabel(frame: CGRect.zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = descriptor.text
            label.font = descriptor.font
            label.textColor = descriptor.textColor
            label.numberOfLines = 0
            return label
        })
    }
    
    static func getTrackCellLabelDescriptors(from track:TrackViewModel) -> [UILabelDescriptor] {
        return [
            UILabelDescriptor(text: track.trackName, font: Defines.Fonts.body, textColor: Defines.Colors.black),
            UILabelDescriptor(text: track.artistName, font: Defines.Fonts.detail, textColor: Defines.Colors.black)
        ]
    }
    
    static func getTrackCellLabels(for track:TrackViewModel) -> [UILabel] {
        return self.createLabels(from: self.getTrackCellLabelDescriptors(from: track))
    }
    
    static func getVenueCellLabelDescriptors(from venue:VenueViewModel) -> [UILabelDescriptor] {
        return [
            UILabelDescriptor(text: venue.venueName, font: Defines.Fonts.body, textColor: Defines.Colors.black),
            UILabelDescriptor(text: venue.locationInfo, font: Defines.Fonts.detail, textColor: Defines.Colors.black),
            UILabelDescriptor(text: venue.type, font: Defines.Fonts.subDetail, textColor: Defines.Colors.black)
        ]
    }
    
    static func getVenueCellLabels(for venue:VenueViewModel) -> [UILabel] {
        return self.createLabels(from: self.getVenueCellLabelDescriptors(from: venue))
    }
    
    static func getTableViewSectionHeader(with text:String) -> UIView {
        let descriptor = UILabelDescriptor(text: text,
                                           font: Defines.Fonts.subtitle,
                                           textColor: Defines.Colors.black)
        guard let label = self.createLabels(from: [descriptor]).first else { return UIView() }
        
        let view = UIView(frame:CGRect.zero)
        
        view.backgroundColor = label.backgroundColor
        view.addSubview(label)
        view.addConstraints([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:Defines.spacings.doubleUnit),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-Defines.spacings.doubleUnit),
        ])
        return view
    }
}
