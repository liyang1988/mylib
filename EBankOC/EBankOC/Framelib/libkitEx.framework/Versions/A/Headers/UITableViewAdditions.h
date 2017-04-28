//
// Copyright 2009 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableView (TTCategory)

/**
 * The view that contains the "index" along the right side of the table.
 */
@property(nonatomic,readonly) UIView* indexView;

/**
 * Returns the margin used to inset table cells.
 *
 * Grouped tables have a margin but plain tables don't.  This is useful in table cell
 * layout calculations where you don't want to hard-code the table style.
 */
@property(nonatomic,readonly) CGFloat tableCellMargin;

- (void)scrollToTop:(BOOL)animated;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToFirstRow:(BOOL)animated;
- (void)scrollToLastRow:(BOOL)animated;
- (void)scrollFirstResponderIntoView;

- (void)touchRowAtIndexPath:(NSIndexPath*)indexPath animated:(BOOL)animated;


//@{block控制下的一些动作
- (void)beginSmartUpdatesForDuration:(NSTimeInterval)duration;
- (void)endSmartUpdates;

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths
              withRowAnimation:(UITableViewRowAnimation)animation
                    completion:(void (^)(void))completion;
- (void)insertSections:(NSIndexSet *)sections
      withRowAnimation:(UITableViewRowAnimation)animation
            completion:(void (^)(void))completion;

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths
              withRowAnimation:(UITableViewRowAnimation)animation
                    completion:(void (^)(void))completion;
- (void)deleteSections:(NSIndexSet *)sections
      withRowAnimation:(UITableViewRowAnimation)animation
            completion:(void (^)(void))completion;

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths
              withRowAnimation:(UITableViewRowAnimation)animation
                    completion:(void (^)(void))completion;
- (void)reloadSections:(NSIndexSet *)sections
      withRowAnimation:(UITableViewRowAnimation)animation
            completion:(void (^)(void))completion;

- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath
               toIndexPath:(NSIndexPath *)newIndexPath
                completion:(void (^)(void))completion;
- (void)moveSection:(NSInteger)section
          toSection:(NSInteger)newSection
         completion:(void (^)(void))completion;
//@}

@end