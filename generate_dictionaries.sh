#./run.sh --lang1=EN --dictOut=test --dictInfo=test --input0=data/inputs/wikiSplit/en/EN.data  --input0Name=enwikitionary --input0Format=enwiktionary --input0LangPattern=English --input0LangCodePattern=en --input0EnIndex=1 --input0WiktionaryType=EnEnglish
# Note: using input1 seems to hang for ZH currently!
while read langcode langname ; do
lang=$(echo $langcode | tr '[a-z]' '[A-Z]')
test "$lang" = "CY" && lang=CI
stoplist=""
test -e data/inputs/stoplists/${langcode}.txt && stoplist="--lang2Stoplist=data/inputs/stoplists/${langcode}.txt"
./run.sh --lang1=EN --lang2=$lang --lang1Stoplist=data/inputs/stoplists/en.txt $stoplist --dictOut=data/outputs/EN-${lang}.quickdic --dictInfo="(EN)Wiktionary-based EN-$lang dictionary." --input0=data/inputs/wikiSplit/en/${lang}.data  --input0Name=enwikitionary --input0Format=enwiktionary --input0LangPattern=${langname} --input0LangCodePattern=${langcode} --input0EnIndex=1 --input0WiktionaryType=EnForeign --input1=data/inputs/wikiSplit/en/EN.data --input1Name=enwikitionary --input1Format=enwiktionary --input1LangPattern=${langname} --input1LangCodePattern=${langcode} --input1EnIndex=1 --input1WiktionaryType=EnToTranslation
rm data/outputs/EN-${lang}.quickdic.v006.zip
7z a -mx=9 data/outputs/EN-${lang}.quickdic.v006.zip ./data/outputs/EN-${lang}.quickdic
done < EN-foreign-dictlist.txt
./run.sh --lang1=EN --lang1Stoplist=data/inputs/stoplists/en.txt --dictOut=data/outputs/EN.quickdic --dictInfo="Wiktionary-based EN dictionary." --input0=data/inputs/wikiSplit/en/EN.data  --input0Name=enwikitionary --input0Format=enwiktionary --input0LangPattern=English --input0LangCodePattern=en --input0EnIndex=1 --input0WiktionaryType=EnEnglish
