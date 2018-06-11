//
//  CountryViewModel.swift
//  Center
//
//  Created by bb on 2017/11/27.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class PhoneCodeViewModel {
    
    lazy var countries = [Country]()
    
    lazy var sortedCountries = [SortedCountry]()
    
    lazy var indexTitles = [String]()
    
}

extension PhoneCodeViewModel {
    //
    func loadData(finishedCallback: @escaping ()->()) {
        guard let path = Bundle.main.path(forResource: "chineseCountryJson", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            guard let str = String(data: data, encoding: String.Encoding.utf8) else { return }
            guard let json = getDictionaryFromJSONString(jsonString: str) else { return }
            guard let arr = json["data"] as? [[String: String]] else { return }
            for dict in arr {
                self.countries.append(Country(dict: dict))
            }
            let array = sort(countries: self.countries)
            self.sortedCountries = divide(countries: array)
        } catch {
            print("error")
        }
        finishedCallback()
    }
    
    // 排序 A -> Z
    func sort(countries: [Country]) -> [Country] {
        let array = countries.sorted { (a, b) -> Bool in
            return a.countryPinyin < b.countryPinyin
        }
        return array
    }
    
    // 拼音分组
    func divide(countries: [Country]) -> [SortedCountry] {
        var sortedCountry = SortedCountry()
        var sortedCountries = [SortedCountry]()
        var tempString = ""
        if !indexTitles.isEmpty {
            indexTitles.removeAll()
        }
        // 遍历
        for country in countries {
            let letter = country.countryPinyin
            // 不同
            if tempString != letter {
                tempString = letter
                sortedCountry = SortedCountry()
                sortedCountry.firstLetter = tempString
                // 分组country
                sortedCountry.countries.append(country)
                // 分组好的sortedCountry
                sortedCountries.append(sortedCountry)
                // 索引
                indexTitles.append(tempString)
            } else {
                // 相同
                sortedCountry.firstLetter = letter
                sortedCountry.countries.append(country)
            }
        }
        return sortedCountries
    }

    // JSON -> Dictionary
    private func getDictionaryFromJSONString(jsonString: String) -> [String: Any]? {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        guard let newDic = dict as? [String: Any] else { return nil }
        return newDic
    }
    
}
