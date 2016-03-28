//
//  PartsModal.h
//  CLWsdht
//
//  Created by OYJ on 16/2/29.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartsModal : NSObject
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *UsrStoreId;
@property (copy, nonatomic) NSString *PartsUseForId;
@property (copy, nonatomic) NSString *PartsTypeId;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *AddDate;
@property (assign, nonatomic) double Price;
@property (copy, nonatomic) NSString *ColourId;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *Spec;
@property (copy, nonatomic) NSString *StoreName;
@property (copy, nonatomic) NSString *UseForName;
@property (copy, nonatomic) NSString *TypeName;
@property (copy, nonatomic) NSString *Img;
@property (copy, nonatomic) NSString *ColourName;
@property (copy, nonatomic) NSString *Url;
@property (copy, nonatomic) NSString *PurityName;
@property (copy, nonatomic) NSString *PartsSrcName;
@property (copy, nonatomic) NSString *PartsSrcId;
@property (copy, nonatomic) NSString *PurityId;
@property (copy, nonatomic) NSString *CarModelSIG;
@property (assign, nonatomic) BOOL Enable;
@property (copy, nonatomic) NSString *Reason;
@property (copy, nonatomic) NSString *ProvincialId;
@property (copy, nonatomic) NSString *CityId;
@property (assign, nonatomic) int Views;
@property (copy, nonatomic) NSString *Mobile;


@end
