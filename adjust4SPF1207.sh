#!/bin/bash    
#cmd to type to modify multiple pictures at the same time
#find location/of/folder/containing/pictures -iname '*.jpeg' -exec location/of/the/script {} \;     

targetRatio=$(echo 16/10 | bc -l) #target ratio 16:10
targetWidth=432
targetHeight=270

imgPath=$1 #get the image path from the first argument of the function
imgName=$(basename "$imgPath")
imgExtension="${imgName##*.}"
imgName="${imgName%.*}"

newImgName="$imgName-432x270.$imgExtension"

width=$(identify $imgPath | cut -f 3 -d " " | sed s/x.*//) #width
height=$(identify $imgPath | cut -f 3 -d " " | sed s/.*x//) #height
ratio=$(echo $width/$height | bc -l) #ratio W/H in floating number

if (( $(echo "$ratio > $targetRatio" |bc -l) ))
	then $(convert -resize x"$targetHeight" -gravity center -crop "$targetWidth"x"$targetHeight"+0+0 +repage $imgPath $newImgName)
	else $(convert -resize "$targetWidth"x -gravity center -crop "$targetWidth"x"$targetHeight"+0+0 +repage $imgPath $newImgName)
fi
