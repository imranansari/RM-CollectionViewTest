class WaterfallViewController < UICollectionViewController
  CELL_IDENTIFIER = "Waterfall cell"
  CELL_WIDTH = 300
  CELL_COUNT = 10

  # we can set a default layout for the WaterfallViewController, can't we?
  def initWithCollectionViewLayout(layout = WaterfallLayout.alloc.init)
    super
  end

  def viewDidLoad
    #@prng = Random.new
    self.collectionView.registerClass(WaterfallCell, forCellWithReuseIdentifier: CELL_IDENTIFIER)

    @photos = []
    dir = NSBundle.mainBundle.bundlePath
    Dir.glob(File.join(dir, "*.jpg")) do |file|
      @photos << UIImage.imageNamed(File.basename(file))
    end

    self.collectionView.collectionViewLayout.tap do |layout|
      layout.item_width = CELL_WIDTH
      layout.column_count = self.collectionView.bounds.size.width / CELL_WIDTH
      layout.section_inset = UIEdgeInsets.new(1, 1, 1, 1)
      layout.delegate = self
    end
    self.collectionView.backgroundColor = UIColor.blackColor
  end

  def collectionView(view, numberOfItemsInSection: section)
    CELL_COUNT
  end

  def collectionView(clv, cellForItemAtIndexPath: index_path)
    clv.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath: index_path).tap do |cell|
      #cell.display_string = "#{index_path.row}"
      cell.imageView.image = @photos[index_path.item]
    end
  end

  def numberOfSectionsInCollectionView(clv)
    1
  end

  def collectionView(clv, layout: layout, heightForItemAtIndexPath: path)
    # images[path.item].size.height this could be done here with images
    # @prng.rand(50..200)
    200
  end

  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape
  end

  def didRotateFromInterfaceOrientation(orientation)
    self.collectionView.collectionViewLayout.tap do |layout|
      layout.column_count = self.collectionView.bounds.size.width / CELL_WIDTH
      width = orientation == UIDeviceOrientationLandscapeRight ||
          orientation == UIDeviceOrientationLandscapeLeft ? 300 : CELL_WIDTH
      layout.item_width = width
    end
  end
end