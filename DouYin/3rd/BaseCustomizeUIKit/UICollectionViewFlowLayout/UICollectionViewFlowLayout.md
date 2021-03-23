#  UICollectionViewFlowLayout

_layout.minimumLineSpacing = KHeight(35);// Y轴方向的Cell之间的间距
_layout.minimumInteritemSpacing = KWidth(20);// X轴方向的Cell之间的间距

xxxxx sizeForItemAtIndexPath:(NSIndexPath *)indexPath
等同于属性 itemSize；

xxxxx insetForSectionAtIndex:(NSInteger)section
等同于属性 sectionInset；

xxxxx minimumLineSpacingForSectionAtIndex:(NSInteger)section
等同于属性 minimumLineSpacing；

xxxxx minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
等同于属性 minimumInteritemSpacing；

作者：FourV
链接：https://www.jianshu.com/p/1e12a2b8f53c
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
