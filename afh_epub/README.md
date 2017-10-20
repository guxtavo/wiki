This is the epub version of "Airplane Flying Handbook" by the FAA. The PDF 
version was meant to be printed and it is difficult to read in a tablet 7"
sreen. Moreover the pdf version doesn't allow text-to-speech, and the epub
can easily be loaded into Google Play Books.

<audiobook> <epub>

Chapter conversion
  * pdf ws2, vi ws1 tmux
  * copy each paragraph
  * add html tags <p>, <ul>, <img>
  * Add (.) to headings and <li>
  * grab screenshots from the pictures
  * convert new images to 96k pixels
  * add description to images
  * correct the headings of the chapter against PDF

TODO
  * ONGOING - chapter convertion - 4
  * chapter convertion - 5
  * chapter convertion - 6
  * chapter convertion - 7
  * chapter convertion - 8
  * chapter convertion - 9
  * chapter convertion - 10
  * chapter convertion - 11
  * chapter convertion - 12
  * chapter convertion - 13
  * chapter convertion - 14
  * chapter convertion - 15
  * chapter convertion - 16
  * chapter convertion - 17
  * chapter convertion - preface
  * chapter convertion - acknoledgments
  * chapter convertion - glossary
  * convert epub to audiobook - voluntary?

TODO DONE
  * OK - try converting 1-3 html version to epub
  * OK - create toc in epub
  * OK - check why epub cannot be uploaded to google books
  * OK - change images path 
  * OK - makes images smaller in size (imagemagick)
         ls *.png | parallel "convert {} -resize 96000@ new_images/{}"
  * OK - create index in epub
  * OK - chapter convertion - 1
  * OK - chapter convertion - 2
  * OK - chapter convertion - 3
  * OK - add description to images 1-3
