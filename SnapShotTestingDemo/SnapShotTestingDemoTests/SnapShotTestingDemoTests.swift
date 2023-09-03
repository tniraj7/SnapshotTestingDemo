import XCTest
@testable import SnapShotTestingDemo
import SnapshotTesting

final class SnapShotTestingDemoTests: XCTestCase {

    func test_snapshot_forFreeAppCell() {
        let cell = FreeAppCell(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: 450, height: 100)
            )
        )
        cell.overrideUserInterfaceStyle = .light

        cell.item = topFreeApps.first
        
        assertSnapshot(matching: cell, as: .image)
    }
    
    func test_snapshotForDarkMode_forFreeAppCell() {
        let cell = FreeAppCell(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: 450, height: 100)
            )
        )
        cell.overrideUserInterfaceStyle = .dark
        
        cell.item = topFreeApps.first
        
        assertSnapshot(matching: cell, as: .image)
    }
    
    func test_snapshot_forFeaturedAppCell() {
        let cell = FeaturedAppsCell(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: 350, height: 180)
            )
        )
        cell.overrideUserInterfaceStyle = .light
        cell.featuredApppItem = featuredApps.first
        
        let exp = XCTestExpectation(description: "Wait for async image load")
        assertSnapshot(matching: cell, as: .image)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.5)
    }
    
    func test_snapshotForDarkMode_forFeaturedAppCell() {
        let cell = FeaturedAppsCell(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: 350, height: 180)
            )
        )
        cell.overrideUserInterfaceStyle = .dark
        cell.featuredApppItem = featuredApps.first
        
        let exp = XCTestExpectation(description: "Wait for async image load")
        assertSnapshot(matching: cell, as: .image)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.5)
    }
    
    func test_snapshot_forHeaderSupplementaryCell() {
        let supplementaryCell = HeaderSupplementaryCell(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: 400, height: 80)
            )
        )
        supplementaryCell.overrideUserInterfaceStyle = .light
        
        let headerTitle = "Editor's Choice"
        supplementaryCell.label.text = headerTitle
        
        assertSnapshot(of: supplementaryCell, as: .image)
    }
    
    func test_snapshotForDarkMode_forHeaderSupplementaryCell() {
        let supplementaryCell = HeaderSupplementaryCell(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: 400, height: 80)
            )
        )
        supplementaryCell.overrideUserInterfaceStyle = .dark
        
        let headerTitle = "Editor's Choice"
        supplementaryCell.label.text = headerTitle
        
        assertSnapshot(of: supplementaryCell, as: .image)
    }
    
    func test_snapshot_forAppStoreViewController() {
        let viewController = AppStoreViewController(nibName: nil, bundle: nil)
        viewController.loadViewIfNeeded()
        viewController.overrideUserInterfaceStyle = .light
        
        let exp = XCTestExpectation(description: "Wait for async image load")
        assertSnapshot(of: viewController, as: .image)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_snapshotForDarkMode_forAppStoreViewController() {
        let viewController = AppStoreViewController(nibName: nil, bundle: nil)
        viewController.overrideUserInterfaceStyle = .dark
        viewController.loadViewIfNeeded()
        
        let exp = XCTestExpectation(description: "Wait for async image load")
        assertSnapshot(of: viewController, as: .image)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
    }
}
