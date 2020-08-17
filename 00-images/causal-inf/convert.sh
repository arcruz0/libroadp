for i in *.pdf; do
  outputname="${i/\.pdf/''}"
  echo $outputname
  pdftoppm $i $outputname -png -singlefile
done
