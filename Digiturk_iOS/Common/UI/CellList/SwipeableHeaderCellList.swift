//
//  CellList.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 3.11.2023.
//

import Foundation
enum SwipeableHeaderViewSectionCellType {
    case ImageCollection, PageControllerCollection
}

enum SwipeableHeaderViewSectionItemType {
    case ImageCollection, PageControllerCollection
}

class SwipeableHeaderCellItem {
    var cellIdentifier: String?
    var cellType: SwipeableHeaderViewSectionCellType?
}

class SwipeableHeaderSectionItem {
    var cellList = [SwipeableHeaderCellItem]()
    var sectionType: SwipeableHeaderViewSectionItemType?
}
