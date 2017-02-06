import UIKit
import Foundation

class SiteCollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let scManager: SiteConfigManager = SiteConfigManager()

    var siteInfos: Array<SiteInfo> = []
    
    weak var viewController: ViewController?
    weak var collectionView: UICollectionView? = nil
    
    let clienCrawler = ClienParkBoardCrawler()
    let ddanziCrawler = TestCrawler()

    public init(_ viewController: ViewController) {
        
        self.viewController = viewController
        
        // load settings
        let scs = scManager.select()
        
        for sc in scs {
            let selectedCrawler: ListCrawler!
            if sc.id == 0 {
                selectedCrawler = clienCrawler
            } else {
                selectedCrawler = ddanziCrawler
            }
            siteInfos.append(SiteInfo(title: sc.name, crawler: selectedCrawler, isOn: sc.isOn))
        }
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = siteInfos.filter{ $0.isOn }.count
        return count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.collectionReuseIdentifier, for: indexPath) as! SiteCollectionViewCell
        cell.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        cell.setText(siteInfos[indexPath.row].title)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let parent = viewController else {
            return
        }
        let addController = BoardViewController(crawler: siteInfos[indexPath.row].crawler, bottomMenuController: parent.bottomMenuController)
        parent.navigationController?.pushViewController(addController, animated: true)
    }
    
    public func reloadCollectionView(){
        siteInfos.removeAll()
        
        // load settings
        let scs = scManager.select()
        
        for sc in scs {
            let selectedCrawler: ListCrawler!
            if sc.id == 0 {
                selectedCrawler = clienCrawler
            } else {
                selectedCrawler = ddanziCrawler
            }
            if sc.isOn {
                siteInfos.append(SiteInfo(title: sc.name, crawler: selectedCrawler, isOn: sc.isOn))
            }
        }
        collectionView?.reloadData()
    }
}
