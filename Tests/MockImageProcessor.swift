// The MIT License (MIT)
//
// Copyright (c) 2017 Alexander Grebenyuk (github.com/kean).

import Foundation
import NukeWebP

extension Image {
    var nk_test_processorIDs: [String] {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.ProcessorIDs) as? [String]) ?? [String]()
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ProcessorIDs, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private struct AssociatedKeys {
    static var ProcessorIDs = "nk_test_processorIDs"
}

// MARK: - MockImageProcessor

class MockImageProcessor: Processing {
    let id: String
    init(id: String) {
        self.id = id
    }
    func process(_ image: Image) -> Image? {
        var processorIDs: [String] = image.nk_test_processorIDs
        processorIDs.append(id)
        let processedImage = Image()
        processedImage.nk_test_processorIDs = processorIDs
        return processedImage
    }
}

func ==(lhs: MockImageProcessor, rhs: MockImageProcessor) -> Bool {
    return lhs.id == rhs.id
}

// MARK: - MockFailingProcessor

class MockFailingProcessor: NukeWebP.Processing {
    func process(_ image: Image) -> Image? {
        return nil
    }
}

func ==(lhs: MockFailingProcessor, rhs: MockFailingProcessor) -> Bool {
    return true
}

