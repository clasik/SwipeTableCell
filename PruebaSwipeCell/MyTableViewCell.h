//
//  MyTableViewCell.h
//  PruebaSwipeCell
//
//  Created by Pablo on 29/6/15.
//  Copyright (c) 2015 Bioshook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTableViewCellDelegate <NSObject>
/**
 *  This method is called when user do swipe on the cell.
 *
 *  @param indexPath selected
 */
- (void)cellSwiper:(NSIndexPath*)indexPath;
@end

@interface MyTableViewCell : UITableViewCell

@property (nonatomic, strong) id<MyTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) IBOutlet UIView *viewFrame;
@property (nonatomic, weak) IBOutlet UILabel *functionLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@end
