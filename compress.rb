#!/usr/bin/env ruby

require 'rmagick'

filenames = Dir[ Dir.pwd + "/**/*.tif" ]

filenames.each do |filename|
  img = Magick::Image::read( filename ).first

  if img.format != "TIFF"
    puts "The file %s has the extension .tif but is a %s image" % [filename, img.format]
    next
  end

  if( img.compression == Magick::NoCompression )
    puts "Converting " + filename
    filesize = img.filesize

    img.compression = Magick::LZWCompression
    img.write filename

    puts "Compressed %s by %d\%" % [filename, 100 - (img.filesize * 100 / filesize) ]
  end
end

