class WaterfallCell < UICollectionViewCell

  attr_accessor :imageView

  def display_string=(string)
    @display_label.text = string unless @display_label.text == string      
  end

  def initWithFrame(frame)
    super

    self.backgroundColor = UIColor.whiteColor
    image = UIImageView.alloc.initWithFrame(
        CGRectMake(3, 3, frame.size.width - 6, frame.size.height - 6))

    image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight

    self.contentView.addSubview(image)
    self.imageView = image
    self
  end
end