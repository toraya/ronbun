//
//  ImageViewController.m
//  Response
//
//  Created by OhnumaRina on 2016/01/24.
//  Copyright (c) 2016年 OhnumaRina. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

//サムネイルの総数
NSInteger _thumbnailNum = 300;
//サムネイルのファイル名を入れる配列
NSMutableArray *_thumbnails;
//サムネイルのファイル名接頭詞
NSString *_thumbnailFilePreffix = @"D_";
//サムネイルのファイル名接尾詞
NSString *_thumbnailFileSuffix = @"_125";
//サムネイル間のマージン
NSInteger _thumbnailMargin = 35;
//サムネイルの外枠の寸法
NSInteger _thumbnailOutlineSize =100;
//サムネイルのボーダーを含まない寸法
NSInteger _thumbnailSize = 95;
//サムネイルの列の数
NSInteger _thumbnailColumnNum = 3;
//サムネイルの列数のカウント
NSInteger _thumbnailColumnCount = 0;
//サムネイルの行数のカウント
NSInteger _thumbnailRowCount = 0;
//サムネイルのボタンの寸法
NSInteger _buttonSize = 80;

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //サムネイルのファイル名を配列に代入
    [self setThumbnailImageResources];
    //サムネイルリストを生成
    [self setThumbnailList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setThumbnailImageResources
{
    //変更可能な配列を初期化
    _thumbnails = [NSMutableArray array];
    for (int i = 1; i <= _thumbnailNum; i++) {
        //拡張子より前のファイル名を保持
        [_thumbnails addObject:[NSString stringWithFormat:@"%@%@",  _thumbnailFilePreffix,[NSString stringWithFormat:@"%d", i]]];
    }
}

//サムネイルリストを生成
- (void)setThumbnailList
{
    //サムネイル群を入れるスクロールビューを初期化
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    int i = 0;
    for (id thumbnailName in _thumbnails) {
        //サムネイルは4列で折り返す
        if (_thumbnailColumnCount == _thumbnailColumnNum) {
            _thumbnailColumnCount = 0;
            _thumbnailRowCount++;
        }
        //サムネイル表示
        NSString *imageFile = [NSString stringWithFormat:@"%@%@", thumbnailName, _thumbnailFileSuffix];
        //画像リソースの取得
        UIImage *image = [self getUIImageFromResources:imageFile ext:@"jpg"];
        UIImageView *thumbnailView = [[UIImageView alloc] initWithImage:image];
        //サムネイルの寸法指定
        CGRect rect = CGRectMake(_thumbnailMargin + (_thumbnailColumnCount * _thumbnailOutlineSize),
                                 _thumbnailMargin + (_thumbnailRowCount * _thumbnailOutlineSize), _thumbnailSize, _thumbnailSize);
        [thumbnailView setFrame:rect];
        //サムネイルをタップ可能にする
        thumbnailView.userInteractionEnabled = YES;
        //ボタン追加
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(0, 0, _buttonSize, _buttonSize);
        //ボタンのタグを代入
        selectButton.tag = i;
        [selectButton addTarget:self action:@selector(selectImage:)
               forControlEvents:UIControlEventTouchUpInside];
        [thumbnailView addSubview:selectButton];
        //スクロールビューにサムネイルを追加
        [scrollView insertSubview:thumbnailView atIndex:[self.view.subviews count]];
        //サムネイルの列を一つ進める
        _thumbnailColumnCount++;
        i++;
    }
    //スクロール範囲の設定
    scrollView.contentSize = CGSizeMake(320, ((_buttonSize) * (_thumbnailRowCount - 1) - (_thumbnailMargin * 2)));
    //スクロールビューをステージに追加
    [self.view addSubview:scrollView];
}

//サムネイルがタップされた時のイベント
- (void)selectImage:(id)sender
{
    //予め代入しておいた tagを取得するためにセレクタを代入
    UIButton *button = (UIButton *)sender;
    //予め代入しておいた tagの数値を出力
    NSLog(@"button.tag: %ld", (long)button.tag);
}

//画像ファイルを取得
- (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:ext];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    return img;
}

@end
