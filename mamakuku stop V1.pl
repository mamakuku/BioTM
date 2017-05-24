use strict;
print "Please input the StopwordCSV:";

my $StopWordFile=<STDIN>;
$StopWordFile=~s/\"//g;#要是路徑有空格，路徑外部會用""套住，導致路徑字串無法啟動
chomp $StopWordFile;#去除變數中的換行字元(並非文章中)
print "Opening ".$StopWordFile."\n";
unless ( open(text,$StopWordFile) ) {
    print "Cannot open file $StopWordFile \n\n";
	 <STDIN>;
	 exit;
}
my @StopWordCSV= <text>; 
close text;#打開目標文件

print "\nStart to input Stopword list\n";
my @StopWords;
for(my $i=0;$i<@StopWordCSV;$i++){
	 my @temp = split ( ',', $StopWordCSV[$i]);
	for my $tmp ( @temp) {
	#print $tmp."\n";
		push( @StopWords, $tmp);
	}
}#對目標檔案內的字元以空格和換行為界線進行排序
undef @StopWordCSV;
print "\nEnd to input Stopword list\n";

#Read Stopword list

print "\nStart to input pubmed abstracts\n";


print "\nPlease input the reporter:\n";
my $textfile=<STDIN>;
$textfile=~s/\"//g;#要是路徑有空格，路徑外部會用""套住，導致路徑字串無法啟動

chomp $textfile;#去除變數中的換行字元(並非文章中)
unless ( open(text,$textfile) ) {
    print "Cannot open file $textfile \n\n";
	 <STDIN>;
	 exit;
}
my @word = <text>; 
close text;#打開目標文件

for(my $i=0;$i<@word;$i++){
	$word[$i] =~s/\W/ /g;#刪除所有英文數字以外的字元(亂碼)
}

my @merged;
for(my $i=0;$i<@word;$i++){
	my @splited = split ( ' ', $word[$i]);
	for my $tmp ( @splited) {
		push( @merged, $tmp);
	}
}#對目標檔案內的字元以空格和換行為界線進行排序

print "\nEnd to input pubmed abstracts\n";

#my @merged = sort @merged;#以字母順序進行再排序
		

my %toRemove;
foreach my $i (@StopWords){
	$toRemove{$StopWords[$i]}=1;
}

my $allword = scalar(@merged) ;
#不需要的Stopword

 for(my$i=0;$i<@merged;$i++){
	 if($merged[$i]=~ /(\d)/){
		 if ($merged[$i]=~/\D/){
	  next;}
		 splice @merged,$i,1,;#除去以上常用詞彙
		 $i=$i-1; 
		 }
 }
	

open (proto,">WordListAndTF.csv")||die "File open error!";


printf proto (my $merged);
for(my$i=0;$i<@merged;$i++){
		printf proto ("$merged[$i]\n");
}

 



close (proto);
exit;