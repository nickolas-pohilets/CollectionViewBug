#import "ViewController.h"

static NSString * const ReuseID = @"ReuseID";

@interface Cell : UICollectionViewCell

@end

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController
{
    IBOutlet UICollectionView *_collectionView;
    UICollectionViewCell *_prototypeCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:Cell.class forCellWithReuseIdentifier:ReuseID];
    
    // Dummy frame that should not matter
    CGRect const dummyFrame = CGRectMake(0, 0, 100, 100);
    NSLog(@"dummyFrame = %@", NSStringFromCGRect(dummyFrame));
    _prototypeCell = [[Cell alloc] initWithFrame:dummyFrame];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:ReuseID forIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Target size is ignored and size is computed according to dummyFrame.
    CGSize targetSize = CGSizeMake(collectionView.frame.size.width, CGFLOAT_MAX);
    NSLog(@"targetSize = %@", NSStringFromCGSize(targetSize));
    CGSize s = [_prototypeCell systemLayoutSizeFittingSize:targetSize
                             withHorizontalFittingPriority:UILayoutPriorityRequired
                                   verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    NSLog(@"s = %@", NSStringFromCGSize(s));
    return s;
}

@end

@implementation Cell

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        UILabel* label = [UILabel new];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies est venenatis justo mattis sollicitudin. Sed in velit tristique, ullamcorper metus quis, consectetur eros. Etiam vel dolor non dolor semper finibus eu at odio. Duis ornare vehicula varius. Mauris eu nibh iaculis, malesuada diam vel, pellentesque augue. Integer ornare sem erat, at aliquet orci commodo id. In vitae sollicitudin ante. Aliquam erat volutpat. Fusce ut sapien nibh. Fusce eleifend, lectus hendrerit tincidunt dignissim, massa massa eleifend mi, in finibus tortor ex sed odio. Suspendisse egestas neque eget dui sodales pellentesque. Aliquam dapibus, odio eget elementum scelerisque, augue purus cursus dolor, ac efficitur neque enim lobortis ex. Nulla tincidunt auctor pharetra. Pellentesque eget nisi et sem luctus ornare. In nec ipsum varius, vehicula est facilisis, posuere turpis.";
        label.translatesAutoresizingMaskIntoConstraints = NO;
        UIView* cv = self.contentView;
        [cv addSubview:label];
        [NSLayoutConstraint activateConstraints:@[
            [label.topAnchor constraintEqualToAnchor:cv.topAnchor],
            [label.leadingAnchor constraintEqualToAnchor:cv.leadingAnchor],
            [label.trailingAnchor constraintEqualToAnchor:cv.trailingAnchor],
            [label.bottomAnchor constraintEqualToAnchor:cv.bottomAnchor],
        ]];
    }
    return self;
}

@end
