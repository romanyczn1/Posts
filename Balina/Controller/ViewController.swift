//
//  ViewController.swift
//  Balina
//
//  Created by Roman Bukh on 15.05.21.
//

import UIKit

class ViewController: UIViewController {
    
    private let dataSource = ViewControllerDataModel()
    
    private var footerView = FooterView()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.tableFooterView = footerView
        tv.separatorStyle = .none
        tv.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        return tv
    }()
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataSource.delegate = self
        dataSource.getPosts()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getNumberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as! PostCell
        cell.configure(with: dataSource.getPost(for: indexPath))
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = self.tableView.bounds.height
        if scrollView.contentOffset.y > (scrollView.contentSize.height - height) * 0.9 && footerView.isShown == false {
            footerView.showLoader()
            dataSource.getPosts()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showImagePicker()
    }
    
    private func showImagePicker() {
        self.imagePicker.present()
    }
    
}

extension ViewController: ViewControllerDataModelDelegate {
    
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.footerView.hideLoader()
        }
    }
    
}

extension ViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if image != nil {
            dataSource.pushImage(image: image!, postId: tableView.indexPathForSelectedRow!)
        }
    }
}

