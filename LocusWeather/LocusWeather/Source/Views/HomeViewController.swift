//
//  ViewController.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 14/05/22.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lookUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lookUpButton.layer.borderWidth = 1
        lookUpButton.layer.borderColor = UIColor.systemOrange.cgColor
        lookUpButton.layer.cornerRadius = 10
        lookUpButton.layer.masksToBounds = true
    }
    
    private func pushToListVC(coordinate: CLLocationCoordinate2D) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "WeatherListViewController") as? WeatherListViewController else { return }
        vc.lat = coordinate.latitude.description
        vc.long = coordinate.longitude.description
        vc.locationName = cityNameTextField.text ?? ""

        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }

    @IBAction func lookUpButtonHandler(_ sender: Any) {
        let address = cityNameTextField.text ?? ""
        
        if address.isEmpty {
            showAlert(in: self, with: "Warning!", message: "Please provide city name.")
        } else {
            getCoordinateFrom(address: address) { coordinate, error in
                guard let coordinate = coordinate, error == nil else {
                    showAlert(in: self, with: "Alert!", message: "Sorry! we could not find this city.")
                    return }

                self.pushToListVC(coordinate: coordinate)
            }
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
