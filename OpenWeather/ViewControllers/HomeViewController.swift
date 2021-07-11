//
//  HomeViewController.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var bookmarksTableView: UITableView!
    @IBOutlet private weak var noBookmarksLabel: UILabel!
    
    //MARK: - Variables
    private var viewModel = AddLocationViewModel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Setup
        addRightBarButton()
        bookmarksTableView.register(cellType: BookmarkLocationCell.self)
        
        //Bind data to UI
        bindDataToUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Update viewModel for new changes
        viewModel.fetchBookmarkedLocations()
    }
    
    private func bindDataToUI() {
        viewModel.bookmarkedLocations.bindAndFire { [weak self] locations in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.noBookmarksLabel.isHidden = locations.count != 0
                self.bookmarksTableView.reloadData()
            }
        }
    }
    
    //MARK: - Bar Buttons
    private func addRightBarButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add,
                                      target: self,
                                      action: #selector(addButtonDidTap(_:)))
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc private func addButtonDidTap(_ sender: Any) {
        let addLocationViewController = AddLocationViewController.initWithNib()
        navigationController?.pushViewController(addLocationViewController,
                                                 animated: true)
    }
}

//MARK: - UITableView Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarkedLocations.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: BookmarkLocationCell.self,
                                                 for: indexPath)
        cell.setupData(viewModel.bookmarkedLocations.value[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cityViewController = CityViewController.initWithNib()
        cityViewController.location = viewModel.bookmarkedLocations.value[indexPath.row]
        navigationController?.pushViewController(cityViewController,
                                                 animated: true)
    }
}

//MARK: - BookmarkLocationCell Delegate
extension HomeViewController: BookmarkLocationCellDelegate {
    func deleteBookmark(at cell: BookmarkLocationCell) {
        if let indexpath = bookmarksTableView.indexPath(for: cell) {
            let location = viewModel.bookmarkedLocations.value[indexpath.row]
            viewModel.removeBookmarkedLocation(location)
        }
    }
}
