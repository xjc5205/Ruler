//
//  HXBuyScrollView.m
//
//  Created by xjc on 16/9/30.
//  Copyright © 2016年 xjc. All rights reserved.
//

#import "HXBuyScrollView.h"
#import "HXCollectionViewCell.h"
#import "HXCollPreCell.h"
#import "HXCollectionReusableView.h"
@interface HXBuyScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>
@end

@implementation HXBuyScrollView{
    
    NSInteger sectionCount;

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        sectionCount = 51;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(100, 50);
        layout.headerReferenceSize = CGSizeMake((SCREEN_WIDTH-30)/2.0 - 50, 50);
        layout.footerReferenceSize = CGSizeMake((SCREEN_WIDTH-30)/2.0f, 50);
        self.hxCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        self.hxCollectionView.backgroundColor = [UIColor whiteColor];
        self.hxCollectionView.showsHorizontalScrollIndicator = NO;
        self.hxCollectionView.delegate = self;
        self.hxCollectionView.dataSource = self;
        [self.hxCollectionView registerNib:[UINib nibWithNibName:@"HXCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXCollectionReusableView"];
        [self.hxCollectionView registerNib:[UINib nibWithNibName:@"HXCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HXCollectionReusableView"];
        self.hxCollectionView.bounces = NO;
        [self addSubview:self.hxCollectionView];
    }
    return self;
}

- (void)createScorll:(NSString *)minString andMax:(NSString *)maxString defaultOffset:(NSString *)offset{
    
    //默认偏移
    self.hxCollectionView.contentOffset = CGPointMake([offset integerValue]/10.0, 0);
    //self.hxCollectionView.contentOffset = CGPointMake([offset floatValue]/10.0, 0);
    //计算section个数
    NSInteger  intMoney = [maxString  intValue];
    sectionCount = intMoney /1000 + 2;
    [self.hxCollectionView reloadData];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        UINib *nib = [UINib nibWithNibName:@"HXCollPreCell" bundle: [NSBundle mainBundle]];
        [collectionView registerNib:nib forCellWithReuseIdentifier:@"HXCollPreCell"];
        HXCollPreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollPreCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
        
    }else{
    
        UINib *nib = [UINib nibWithNibName:@"HXCollectionViewCell" bundle: [NSBundle mainBundle]];
        [collectionView registerNib:nib forCellWithReuseIdentifier:@"HXCollectionViewCell"];
        HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row)* 1000];
        return cell;
        
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return sectionCount;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView* view = [self.hxCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXCollectionReusableView" forIndexPath:indexPath];
        return view;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView* view = [self.hxCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HXCollectionReusableView" forIndexPath:indexPath];
        return view;
    }else{
        return nil;
    }
}
@end
