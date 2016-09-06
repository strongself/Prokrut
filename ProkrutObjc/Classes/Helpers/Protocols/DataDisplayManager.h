//
//  DataDisplayManager.h
//
//  Created by Egor Tolstoy on 12/10/14.
//  Copyright (c) 2014 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DataDisplayManager <NSObject>

@optional

/**
 *  @author Egor Tolstoy
 *
 *  Метод, отдающий dataSource для таблицы.
 *
 *  @param tableView Контроллер, чья таблица нас интересует
 *
 *  @return (id<UITableViewDataSource>)
 */
- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView;

/**
 *  @author Egor Tolstoy
 *
 *  Метод, отдающий делегата для таблицы. Сам DDM в данном случае не выступает делегатом напрямую.
 *
 *  @param tableView      Таблица, делегат для которой нам нужен
 *  @param baseTableViewDelegate Основной делегат таблицы (к примеру, UITableViewController) - этот параметр нужен для форвардинга части делегатных методов
 *
 *  @return Делегат для таблицы
 */
- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView
                               withBaseDelegate:(id <UITableViewDelegate>)baseTableViewDelegate;

@end