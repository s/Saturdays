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
        stackView.spacing = UIDefines.Spacings.singleUnit
        
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
        view.backgroundColor = UIDefines.Colors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        shimmeringView.contentView = view
        return shimmeringView
    }
    
    static func createLabels(from configurations:***REMOVED***UILabelDescriptor***REMOVED***) -> ***REMOVED***UILabel***REMOVED*** {
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
    
    static func getTrackCellLabelDescriptors(from track:TrackViewModel) -> ***REMOVED***UILabelDescriptor***REMOVED*** {
        return ***REMOVED***
            UILabelDescriptor(text: track.trackName, font: UIDefines.Fonts.body, textColor: UIDefines.Colors.black),
            UILabelDescriptor(text: track.artistName, font: UIDefines.Fonts.detail, textColor: UIDefines.Colors.black)
***REMOVED***
    }
    
    static func getTrackCellLabels(for track:TrackViewModel) -> ***REMOVED***UILabel***REMOVED*** {
        return self.createLabels(from: self.getTrackCellLabelDescriptors(from: track))
    }
    
    static func getVenueCellLabelDescriptors(from venue:VenueViewModel) -> ***REMOVED***UILabelDescriptor***REMOVED*** {
        return ***REMOVED***
            UILabelDescriptor(text: venue.venueName, font: UIDefines.Fonts.body, textColor: UIDefines.Colors.black),
            UILabelDescriptor(text: venue.locationInfo, font: UIDefines.Fonts.detail, textColor: UIDefines.Colors.black),
            UILabelDescriptor(text: venue.type, font: UIDefines.Fonts.subDetail, textColor: UIDefines.Colors.black)
***REMOVED***
    }
    
    static func getVenueCellLabels(for venue:VenueViewModel) -> ***REMOVED***UILabel***REMOVED*** {
        return self.createLabels(from: self.getVenueCellLabelDescriptors(from: venue))
    }
    
    static func getTableViewSectionHeader(with text:String) -> UIView {
        let descriptor = UILabelDescriptor(text: text,
                                           font: UIDefines.Fonts.subtitle,
                                           textColor: UIDefines.Colors.black)
        guard let label = self.createLabels(from: ***REMOVED***descriptor***REMOVED***).first else { return UIView() }
        
        let view = UIView(frame:CGRect.zero)
        
        view.backgroundColor = label.backgroundColor
        view.addSubview(label)
        view.addConstraints(***REMOVED***
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:UIDefines.Spacings.doubleUnit),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-UIDefines.Spacings.doubleUnit),
***REMOVED***)
        return view
    }
}
