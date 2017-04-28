//
//  EBAddOptionsViewController.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/19.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBAddOptionsViewController.h"

#import "EBWorkTypeTableViewController.h"
@interface EBAddOptionsViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSMutableArray *marryPhoto;
@property(nonatomic,strong)UIImagePickerController *imgPicker;
@end

@implementation EBAddOptionsViewController
- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (NSMutableArray *)marryPhoto{
    
    if (nil == _marryPhoto) {
        _marryPhoto = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"addPhotoBtn"], nil];
    }
    return _marryPhoto;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(0 == indexPath.row){
        return 30;
    }else{
        CGFloat height = (self.marryPhoto.count+2)/3 * 110;
        if (height == 0) {
            height = 110;
        }
        return height;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        static NSString *ident = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        }
        cell.textLabel.text = @"添加审批照片";
        cell.textLabel.font = EBNormalFont;
        return cell;
    }else{
        static NSString *ident = @"cellPoto";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
            cell.selected = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        CGFloat columW = (tableView.width - 40 - 3 *90) / 3;
        CGFloat rowH = 10;
        __weak typeof(UITableViewCell*)cellB= cell;
        if (cell.contentView.subviews > 0) {
            [cell.contentView removeAllSubviews];
        }
        [self.marryPhoto enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat x = idx%3 * ( 90 + columW) + 10;
            CGFloat y = idx/3 * (90 + rowH) + rowH;
            
            if (self.marryPhoto.count -1 == idx) {
                UIButton *imgV = [UIButton buttonWithType:UIButtonTypeCustom];
                [imgV setBackgroundImage:obj forState:UIControlStateNormal];
                imgV.frame = CGRectMake(x, y, 90, 90);
                [imgV addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
                [cellB.contentView addSubview:imgV];
            }else{
                UIImageView *imgView = [[UIImageView alloc] initWithImage:obj];
                imgView.frame =  CGRectMake(x, y, 90, 90);
                [cellB.contentView addSubview:imgView];
            }
        
            
        }];
        return cell;
        
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.backgroundColor = [UIColor blueColor];
    [footBtn setTitle:@"审核提交" forState:UIControlStateNormal];
    UIView *view = [[UIView alloc] init];
    
    view.frame = CGRectMake(0, 0, tableView.width, 100);
    [view addSubview:footBtn];
    //    footBtn. = tableView.width/2.0;
    ////    footBtn.centerY = view.centerY;
    footBtn.frame = CGRectMake(tableView.width/2.0-125, 50, 250, 45);
    footBtn.layer.cornerRadius = 20;
    footBtn.layer.masksToBounds = YES;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
- (void)addPhoto:(UIButton*)sender{
    UIImagePickerController *imgPick = [[UIImagePickerController alloc] init];
    imgPick.delegate = self;
    __weak typeof(self) vc = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
             imgPick.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            CenterMessage(@"不支持拍照功能");
            return;
        }
       [vc presentViewController:imgPick animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imgPick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        }else{
            CenterMessage(@"不支持查看相册功能");
            return;
        }
        [vc presentViewController:imgPick animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
   
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 获得编辑过的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *imgthumb = [image scaleToSize:CGSizeMake(90, 90)];
    [self.marryPhoto insertObject:imgthumb atIndex:0];
    [self.tableView reloadData];
    // 把图片转成NSData类型的数据来保存文件(存入到沙盒中)
    NSData *imageData;
    
    // 判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        // 返回为png图像。
        imageData = UIImagePNGRepresentation(image);
    }else {
        // 返回为JPEG图像
        imageData = UIImageJPEGRepresentation(image, 1.0);
    }
    // 路径拼接,写入-----
    NSString * imageSavePath =[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"str.png"];
    [imageData writeToFile:imageSavePath atomically:YES];
    // 关闭相册界面
    [self dismissModalViewControllerAnimated:YES];
}
@end
