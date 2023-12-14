//
//  ListViewDelegate.swift
//  SparkDemo
//
//  Created by alican.aycil on 01.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

final class ListViewDelegate: NSObject, UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


