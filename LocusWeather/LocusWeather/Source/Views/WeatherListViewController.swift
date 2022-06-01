//
//  WeatherListViewController.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 16/05/22.
//

import UIKit

class WeatherListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var model = WeatherListViewModel(networkManager: NetworkManager())
    var lat: String = ""
    var long: String = ""
    var locationName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = locationName
        tableView.register(UINib(nibName: "WeatherListCell", bundle: Bundle.main), forCellReuseIdentifier: "WeatherListCell")
        tableView.tableFooterView = UIView()
        
        model.delegate = self
        
        do {
            try model.getWeatherList(lat: lat, long: long)
        } catch {
            switch error {
            case WeatherError.wrongURL(let str) :
                showAlert(in: self, with: "Error!", message: str)
            default:
                print("")
            }
        }
    }
    
    private func pushToWeatherDetailsVC(indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "WeatherDetailsViewController") as? WeatherDetailsViewController else { return }
        vc.weatherViewModel = model.weatherList[indexPath.row]
        vc.location = locationName
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension WeatherListViewController: WeatherListViewModelDelegate {
    func refreshView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func serviceFailed(message: String) {
        showAlert(in: self, with: "Error!", message: message)
    }
}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.weatherList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell") as? WeatherListCell else { return UITableViewCell() }
        cell.accessoryType = .disclosureIndicator
        cell.weatherStatus.text = model.weatherList[indexPath.row].weatherStatus
        cell.weatherTemp.text = "Temp: " + model.weatherList[indexPath.row].temp
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToWeatherDetailsVC(indexPath: indexPath)
    }
}

