import UIKit

// MARK: Identifiable
public protocol ReuseIdentifiable {
}

public extension ReuseIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

// Collections
extension UICollectionReusableView: ReuseIdentifiable { }
extension UITableViewCell: ReuseIdentifiable { }

public extension UITableView {
    
    func register<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }

    func loadCell<Cell: UITableViewCell>(for index: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.identifier, for: index) as? Cell else {
            fatalError("Missing cell type on table.")
        }
        return cell
    }
}

public extension UICollectionView {

    func loadCell<Cell: UICollectionViewCell>(for index: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: index) as? Cell else {
            fatalError("Missing cell type on collection.")
        }
        return cell
    }
    
    func loadHeader<Header: UICollectionReusableView>(for index: IndexPath) -> Header {
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier, for: index) as? Header else {
            fatalError("Missing header type on collection.")
        }
        return view
    }
    
    func loadFooter<Footer: UICollectionReusableView>(for index: IndexPath) -> Footer {
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Footer.identifier, for: index) as? Footer else {
            fatalError("Missing footer type on collection.")
        }
        return view
    }

    func register<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func register<View: UICollectionReusableView>(footer: View.Type) {
        register(footer, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footer.identifier)
    }
    
    func register<View: UICollectionReusableView>(header: View.Type) {
        register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.identifier)
    }
}
