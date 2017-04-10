#print "Please input the reporter:";
$textfile="temp.txt";#�ťո��|���D�L�k�ѨM�A�n�ѩ��U��code�ƦX�~�i
$textfile=~s/\"//g;#�n�O���|���Ů�A���|�~���|��""�M��A�ɭP���|�r��L�k�Ұ�

chomp $textfile;#�h���ܼƤ�������r��(�ëD�峹��)
unless ( open(text,$textfile) ) {
    print "Cannot open file $textfile \n\n";
	 <STDIN>;
	 exit
}
@word = <text>; 
close text;#���}�ؼФ��
for($i=0;$i<@word;$i++){
	$word[$i] =~s/\W/ /g;#�R���Ҧ��^��Ʀr�H�~���r��(�ýX)
	}

for($i=0;$i<@word;$i++){
	@splited = split ( ' ', $word[$i]);
	for my $tmp ( @splited) {
		push( @merged, $tmp);
	}
}#��ؼ��ɮפ����r���H�Ů�M���欰�ɽu�i��Ƨ�
@merged = sort @merged;#�H�r�����Ƕi��A�Ƨ�
	
$htmlStart ='<html>
<head></head>
<body>
<div id="pieChart"></div>
<script src="http://cdnjs.cloudflare.com/ajax/libs/d3/3.4.4/d3.min.js"></script>
<script src="d3pie.min.js"></script>
<script>
var pie = new d3pie("pieChart", {
	"header": {
		"title": {
			"text": "Possible Proper noun",
			"fontSize": 24,
			"font":"open sans"
		},
		"subtitle": {
			"text": "",
			"color": "#999999",
			"fontSize": 12,
			"font": "open sans"
		},
		"titleSubtitlePadding": 9
	},
	"footer": {
		"color": "#999999",
		"fontSize": 10,
		"font": "open sans",
		"location": "bottom-left"
	},
	"size": {
		"canvasHeight": 220,
		"canvasWidth": 400,
		"pieInnerRadius": "50%",
		"pieOuterRadius": "90%"
	},
	"data": {
		"sortOrder": "value-desc",
			"smallSegmentGrouping": {
			"enabled": true,
			"value": 1
		},
		"content":[';

		
		
$htmlEnd ='		]
	},
	"labels": {
		"outer": {
			"pieDistance": 32
		},
		"inner": {
			"hideWhenLessThanPercentage": 3
		},
		"mainLabel": {
			"fontSize": 11
		},
		"percentage": {
			"color": "#ffffff",
			"decimalPlaces": 0
		},
		"value": {
			"color": "#adadad",
			"fontSize": 11
		},
		"lines": {
			"enabled": true
		},
		"truncation": {
			"enabled": true
		}
	},
	"effects": {
		"pullOutSegmentOnClick": {
			"effect": "linear",
			"speed": 400,
			"size": 8
		}
	},
	"misc": {
		"gradient": {
			"enabled": true,
			"percentage": 100
		}
	}
});
</script>

</body>
</html>';




open (proto,">All upper case to d3pie.html")||die "File open error!";
printf proto ($htmlStart);
$count=1;

	
for($i=0;$i<@merged;$i++){
	if($merged[$i] eq $merged[$i+1]){
		$count++;
	}
	elsif($merged[$i] =~ /[A-Z]/  || $merged[$i] =~ /[A-Z].[A-Z]/ ){#�D�X��r�����@�Ӥj�g�r���A�άO��Ӥj�g�ﴡ�p�g�Ʀr���r��
		my $range = 256;#�]�w�üƽd��
	my $random_number = int(rand($range));#�ͦ���ƶü�
	my $r = int(rand($range));#�üƬ�
	my $g = int(rand($range));#�ü���
	my $b = int(rand($range));#�üƺ�

	$hex_r = sprintf("%x", $r);
	print $hex_r;#�üƬ�hex��

	$hex_g = sprintf("%x", $g);
	print $hex_g;#�üƺ�hex��

	$hex_b = sprintf("%x", $b);
	print $hex_b;#�ü���hex��
	printf proto ("{\"label\":\"$merged[$i]\",\n\"value\":$count,\n\"color\":\"\#$hex_r$hex_g$hex_b\"},\n");

		#printf proto ("$merged[$i],$count\n");
		$count=1;
	} 
	else{
		delete $merged[$i] ;
		$count=1;
	}
}
printf proto ($htmlEnd);
close (proto);
#system "All upper case to d3pie.html";
exit;