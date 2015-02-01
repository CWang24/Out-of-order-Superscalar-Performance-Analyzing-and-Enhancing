#!/usr/local/bin/perl   
my $uniformwidth=4;my $cache_dl1_bsize=32;my $cache_il1_bsize=32;my $cache_dl2_bsize=64;
my $seed=1;
my $fetch_ifqsize=$uniformwidth;
my $fetch_mplat=3;
my $bpred='2lev';########## branch predictor type {nottaken|taken|perfect|bimod|2lev|comb}
my $bpred_bimod=2048;##
my $bpred_2lev_ll1size=4096;##
my $bpred_2lev_l2size=2097152;##
my $bpred_2lev_hist_size=9;   my $xor=0;####
my $decode_width=$uniformwidth;
my $issue_width=$uniformwidth;
my $issue_inorder="'false";
my $issue_wrongpath="'true";
my $ruu_size=64;##
my $lsq_size=256;###
my $cache_dl1_number_of_sets=2048;####
my $cache_dl1_byte_per_line=$cache_dl1_bsize;####
my $cache_dl1_associativity=4;####
my $cache_dl1='l';####
my $cache_dl1lat=1;####
my $cache_dl2_number_of_sets=4096;####
my $cache_dl2_byte_per_line=$cache_dl2_bsize;####
my $cache_dl2_associativity=4;###############
my $cache_dl2='l';####
my $cache_dl2lat=6;####
my $cache_il1_number_of_sets=2048;####
my $cache_il1_byte_per_line=$cache_il1_bsize;####
my $cache_il1_associativity=4;###############
my $cache_il1='l';####
my $cache_il1lat=1;####
my $cache_il2_number_of_sets='dl2';####
my $cache_il2_byte_per_line=();####
my $cache_il2_associativity=();#$cache_il2_byte_per_line/$cache_il2_byte_per_line;#0;################
my $cache_il2=();####
my $cache_il2lat=();####
my $cache_flush="'false";
my $cache_icompress="'false";
my $mem_lat_first=100;
my $mem_lat_inter=20;
my $mem_width=8;
my $tlb_itlb_number_of_lines=16;
my $tlb_itlb_sys_page_size=4096;
my $tlb_itlb_associativity=4;
my $tlb_itlb_repl_strg='l';
my $tlb_dtlb_number_of_lines=32;
my $tlb_dtlb_sys_page_size=4096;
my $tlb_dtlb_associativity=4;
my $tlb_dtlb_repl_strg='l';
my $tlb_lat=100;
my $res_ialu=2;#########
my $res_imult=1;#########
my $res_memport=2;#########
my $res_fpalu=2;#########
my $res_fpmult=1;#########
my $bugcompat="'false";
my $blank=();
my $BTB=4096;   my $BTBnum_sets=1024; my $BTBasso=8;

my $ras=4;####### return address stack size (0 for no return stack)
#
my $file00='cw557proj1.config';
my $file01='CW557proj2_01.config';
#read and modify Excel based Real Estimator 
use Win32::OLE;
use strict;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';
$Win32::OLE::Warn = 3;                                # die on errors...
# get already active Excel application or open new
my $Excel = Win32::OLE->GetActiveObject('Excel.Application')
     || Win32::OLE->new('Excel.Application', 'Quit');   # get already active Excel
# open Excel file
my $Book = $Excel->Workbooks->Open("c:/perltest/estimator_v3.xls");
$Excel->{Visible} = 1;
my $Sheet = $Book->Worksheets(1);
my $array = $Sheet->Range("B3:B58")->{'Value'};         # get the contents
$Sheet->Range("B3:B58")->{'Value'}=
[["$seed"],
["$fetch_ifqsize"],
["$fetch_mplat"],
["$bpred"],
["$bpred_bimod"],
["$bpred_2lev_ll1size"],
["$bpred_2lev_l2size"],
["$bpred_2lev_hist_size"],
["$decode_width"],
["$issue_width"],
["$issue_inorder"],
["$issue_wrongpath"],
["$ruu_size"],
["$lsq_size"],
["$cache_dl1_number_of_sets"],
["$cache_dl1_byte_per_line"],
["$cache_dl1_associativity"],
["$cache_dl1"],
["$cache_dl1lat"],
["$cache_dl2_number_of_sets"],
["$cache_dl2_byte_per_line"],
["$cache_dl2_associativity"],
["$cache_dl2"],
["$cache_dl2lat"],
["$cache_il1_number_of_sets"],
["$cache_il1_byte_per_line"],
["$cache_il1_associativity"],
["$cache_il1"],
["$cache_il1lat"],
["$cache_il2_number_of_sets"],
["$cache_il2_byte_per_line"],
["$cache_il2_associativity"],
["$cache_il2"],
["$cache_il2lat"],
["$cache_flush"],
["$cache_icompress"],
["$mem_lat_first"],
["$mem_lat_inter"],
["$mem_width"],
["$tlb_itlb_number_of_lines"],
["$tlb_itlb_sys_page_size"],
["$tlb_itlb_associativity"],
["$tlb_itlb_repl_strg"],
["$tlb_dtlb_number_of_lines"],
["$tlb_dtlb_sys_page_size"],
["$tlb_dtlb_associativity"],
["$tlb_dtlb_repl_strg"],
["$tlb_lat"],
["$res_ialu"],
["$res_imult"],
["$res_memport"],
["$res_fpalu"],
["$res_fpmult"],
["$bugcompat"],
["$blank"],
["$BTB"]];
print"what we modified just now:\n";
my $array = $Sheet->Range("B3:C58")->{'Value'};
foreach my $ref_array (@$array) {                      # loop through the array
                                                       # referenced by $array
     foreach my $scalar (@$ref_array) {
         print "$scalar\t";
     }
     print "\n";
} 
print"Calculation result by Real Estimator:\n************************************\n";
#get RUU port#
my $Sheet = $Book->Worksheets(3);
my $RUUread_ports=$Sheet->Cells(18,2)->{'Value'};
my $RUUwrite_ports=$Sheet->Cells(19,2)->{'Value'};
print "RUU read_ports=$RUUread_ports ";
print "RUU write_ports=$RUUwrite_ports  ";
#get total ruu bits
my $Sheet = $Book->Worksheets(4);
my $TotalRUUbits=$Sheet->Cells(20,2)->{'Value'};
my $RUUentry_bits=$Sheet->Cells(19,2)->{'Value'};
print "TotalRUUbits=$TotalRUUbits.\n";
print "RUUentry_bits=$RUUentry_bits.\n";
my $nrofbitsreadout=0;
if($RUUentry_bits<156)
{$nrofbitsreadout=152;}
else
{$nrofbitsreadout=160;}


#get l1dc port#
my $Sheet = $Book->Worksheets(3);
my $L1DCread_ports=$Sheet->Cells(30,2)->{'Value'};
my $L1DCwrite_ports=$Sheet->Cells(31,2)->{'Value'};
print "L1DC read_ports=$L1DCread_ports ";
print "L1DC write_ports=$L1DCwrite_ports  ";
#get total l1dc bits
my $Sheet = $Book->Worksheets(4);
my $TotalL1DCbits=$Sheet->Cells(43,2)->{'Value'};
print "TotalL1DCbits=$TotalL1DCbits.\n";

#get l1Ic port#
my $Sheet = $Book->Worksheets(3);
my $L1ICread_ports=$Sheet->Cells(28,2)->{'Value'};
my $L1ICwrite_ports=$Sheet->Cells(29,2)->{'Value'};
print "L1IC read_ports=$L1ICread_ports ";
print "L1IC write_ports=$L1ICwrite_ports  ";
#get total l1Ic bits
my $Sheet = $Book->Worksheets(4);
my $TotalL1ICbits=$Sheet->Cells(51,2)->{'Value'};
print "TotalL1ICbits=$TotalL1ICbits.\n";

#get l2Ic port#
my $Sheet = $Book->Worksheets(3);
my $L2ICread_ports=$Sheet->Cells(32,2)->{'Value'};
my $L2ICwrite_ports=$Sheet->Cells(33,2)->{'Value'};
print "L2IC read_ports=$L2ICread_ports ";
print "L2IC write_ports=$L2ICwrite_ports  ";
#get total l1Ic bits
my $Sheet = $Book->Worksheets(4);
my $TotalL2ICbits=$Sheet->Cells(67,2)->{'Value'};
print "TotalL2ICbits=$TotalL2ICbits.\n";

#get l2Dc port#
my $Sheet = $Book->Worksheets(3);
my $L2DCread_ports=$Sheet->Cells(34,2)->{'Value'};
my $L2DCwrite_ports=$Sheet->Cells(35,2)->{'Value'};
print "L2DC read_ports=$L2DCread_ports ";
print "L2DC write_ports=$L2DCwrite_ports  ";
#get total l1Ic bits
my $Sheet = $Book->Worksheets(4);
my $TotalL2DCbits=$Sheet->Cells(59,2)->{'Value'};
print "TotalL2DCbits=$TotalL2DCbits.\n";

print"Before we write the .config file, we should check the transistor count and area with Real Estimator first.\n";
#transistor count 
my $Sheet = $Book->Worksheets(5);
my $ttTrC=$Sheet->Cells(72,2)->{'Value'};
my $ttTrCC=int($ttTrC/1000000);
print "total transistor count: $ttTrC, which is  $ttTrCC million \n";
#area 
my $Sheet = $Book->Worksheets(6);
my $ttA=$Sheet->Cells(109,2)->{'Value'};
my $ttAA=$ttA * 256E-12;
print "total area: $ttA, which is $ttAA mm2\n";
print "while the limits are:\n Transistor count: 240 million\n Area: 22 mm2\n*****************************\n";

# clean up
$Book->Save;
$Book->Close;
#system("notepad submit3.pl");


print"fill in Cacti online form and get the result of RUU:\n";
#Get RUU access time using Cacti Pure RAM Interface
#submit online forms on Cacti Pure RAM Interface.
use WWW::Mechanize; 
my $mech = WWW::Mechanize->new;
$mech->get('http://quid.hpl.hp.com:9081/cacti/sram.y?new');
$mech->submit_form(
    with_fields => {
        'cache_size'=>$TotalRUUbits/8,#RAM Size (bytes)
		'nrbanks'=>1,#Nr. of Banks
		'rwports'=>0,
		'read_ports'=>$RUUread_ports,
		'write_ports'=>$RUUwrite_ports,
		'ser_ports'=>0,#Single Ended Read Ports
		'output'=>$nrofbitsreadout,#Nr. of Bits Read Out
		'technode'=>32,
		'temp'=>360,#Temperature (300-400 K, steps of 10)
		'data_arr_ram_cell_tech_flavor_in'=>0,
		'data_arr_periph_global_tech_flavor_in'=>0,
		'tag_arr_ram_cell_tech_flavor_in'=>0,
		'tag_arr_periph_global_tech_flavor_in'=>0,
		'interconnect_projection_type_in'=>1,
		'wire_outside_mat_type_in'=>0,
		#'technode'=>64,
		
    }
	#Radiobutton => {}
);
#print result website content to local file
my $file0 = 'RUUbyCacti.html';
open(OUT,">$file0");
print OUT $mech->content;
close(OUT);
#get RUU access time by analyse the local file
open(INFO,$file0)||die"$!";
my @data_lines=<INFO>;
close(INFO);
my $count=0;
my $RUUAccessTime=0;
foreach my $neirong (@data_lines)
{
  $count++;
  #print "neirong\n";
  if ($neirong=~/Access time/)
  {
    chop $neirong;
	chop $neirong;
	chop $neirong;
	chop $neirong;
	chop $neirong;
	my @AccessTime=split(/\s+/,$neirong);
	
	 $RUUAccessTime=$AccessTime[4];
	print "RUU Access time is $RUUAccessTime ns.\n";
  }
  #if ($neirong=~/Total area/)
  #{print "area is $neirong";}
}
#print "$count lines in total\n*******************\n";
print"fill in Cacti online form and get the results of Caches:\n";
my $l1icAccessTime=0;
my $l1dcAccessTime=0;
my $l2dcAccessTime=0;
my $file1 = 'l1icCachebyCacti.html';
my $file2 = 'l1dcCachebyCacti.html';
my $file3 = 'l2dcCachebyCacti.html';
#Nr. Of Bits per Tag3 = 30 for L1 Data, 30 for L1 Instruction, and 25 for L2 cache
&CACHEbyCacti('l1ic',$TotalL1ICbits,$cache_il1_byte_per_line,$L1ICread_ports,$L1ICwrite_ports,$file1,$l1icAccessTime,30,$cache_il1_associativity);
&CACHEbyCacti('l1dc',$TotalL1DCbits,$cache_dl1_byte_per_line,$L1DCread_ports,$L1DCwrite_ports,$file2,$l1dcAccessTime,30,$cache_dl1_associativity);
&CACHEbyCacti('l2dc',$TotalL2DCbits,$cache_dl2_byte_per_line,$L2DCread_ports,$L2DCwrite_ports,$file3,$l2dcAccessTime,25,$cache_dl2_associativity);
#        $_(0)=name,$_(1)=total_bits,$_(2)=byte_per_line,    $_(3)=readport, $_(4)=writeport, $_(5)=fileNo,               $_(8)=Associativity

print"
l1icAccessTime=$l1icAccessTime
l1dcAccessTime=$l1dcAccessTime
l2dcAccessTime=$l2dcAccessTime
";
#print"latency calculation:\n";
my $dl1lat=int($l1dcAccessTime/$RUUAccessTime)+1;
my $dl2lat=int($l2dcAccessTime/$RUUAccessTime)+1;
my $il1lat=int($l1icAccessTime/$RUUAccessTime)+1;
#$il2lat=
print"
l1icLatency=$il1lat
l1dcLatency=$dl1lat
l2dcLatency=$dl2lat
";
print"Open Cacti results for check:...\n";
#system("RUUbyCacti.html");
#system("l1icCachebyCacti.html");
#system("l1dcCachebyCacti.html");
#system("l2dcCachebyCacti.html");




print"now we have enough information to modify and complete the .config file\n";

#
open(INFO,$file00)||die"$!";
my @origin=<INFO>;
close(INFO);
open(OUTP,">$file01");
my $count=0;
foreach my $neirong (@origin)
{
  #chomp $neirong;
  my $flag=0;
  if($neirong=~'-fetch:mplat ')
  { $flag=1;print OUTP "-fetch:mplat                      3 \n";}####???allow to change
  if($neirong=~'-bpred ')
  { $flag=1;print OUTP "-bpred                       $bpred \n";}
  if($neirong=~'-bpred:2lev')
  { $flag=1;print OUTP "-bpred:2lev            $bpred_2lev_ll1size $bpred_2lev_l2size $bpred_2lev_hist_size $xor \n";}

  if($neirong=~'-commit:width')
  { $flag=1;print OUTP "-commit:width                     $uniformwidth \n";}
  if($neirong=~'-decode:width')
  { $flag=1;print OUTP "-decode:width                     $uniformwidth \n";} 
  if($neirong=~'-issue:width')
  { $flag=1;print OUTP "-issue:width                      $uniformwidth \n";}
  
  if($neirong=~'-fetch:ifqsize')
  { $flag=1;print OUTP "-fetch:ifqsize                    $uniformwidth \n";}
  
  if($neirong=~'-ruu:size')
  { $flag=1;print OUTP "-ruu:size                        $ruu_size \n";}
  
  if($neirong=~'-lsq:size')
  { $flag=1;print OUTP "-lsq:size                         $lsq_size \n";}
  
  if($neirong=~'-res:ialu')
  { $flag=1;print OUTP "-res:ialu                         $res_ialu \n";}
  if($neirong=~'-res:imult')
  { $flag=1;print OUTP "-res:imult                        $res_imult \n";}
  
  if($neirong=~'-res:fpalu')
  { $flag=1;print OUTP "-res:fpalu                        $res_fpalu \n";}
  if($neirong=~'-res:fpmult')
  { $flag=1;print OUTP "-res:fpmult                       $res_fpmult \n";}
  
  if($neirong=~'-bpred:ras')
  { $flag=1;print OUTP "-bpred:ras                        $ras \n";}
  if($neirong=~'-bpred:btb')## BTB config (<num_sets> <associativity>)
  { $flag=1;print OUTP "-bpred:btb             $BTBnum_sets $BTBasso \n";}
    
   
   
   
  if($neirong=~'dl1lat')
  { $flag=1;print OUTP "-cache:dl1lat                     $dl1lat \n";}
  if($neirong=~'dl2lat')
  { $flag=1;print OUTP "-cache:dl2lat                     $dl2lat \n";}
  if($neirong=~'il1lat')
  { $flag=1;print OUTP "-cache:il1lat                     $il1lat \n";}
  
  if($neirong=~'-cache:dl1 ')
  { $flag=1;print OUTP "-cache:dl1             dl1:$cache_dl1_number_of_sets:$cache_dl1_bsize:$cache_dl1_associativity:$cache_dl1 \n";}
  if($neirong=~'-cache:il1 ')                            #< name>:<nsets>:<bsize>:<assoc>:<repl>
  { $flag=1;print OUTP "-cache:il1             il1:$cache_il1_number_of_sets:$cache_il1_bsize:$cache_il1_associativity:$cache_il1 \n";}
  if($neirong=~'-cache:dl2 ')
  { $flag=1;print OUTP "-cache:dl2             ul2:$cache_dl2_number_of_sets:$cache_dl2_bsize:$cache_dl2_associativity:$cache_dl2 \n";}      


  
  if($neirong=~'-res:memport')
  { $flag=1;print OUTP "-res:memport                      $res_memport \n";}
                         
  if($flag==0)
  {
    print OUTP "$neirong";
  }
}
print "new .config file generated.\n";



sub CACHEbyCacti#$_(0)=name,$_(1)=total_bits,$_(2)=byte_per_line,$_(3)=readport,$_(4)=writeport,$_(5)=fileNo,$_(
{
#submit online forms on Cacti Detailed Interface.
#use WWW::Mechanize; 
my $mech = WWW::Mechanize->new;
my $total_bytes=$_[1]/8;
my $Nr_of_Bits_Read_Out=$_[2]*8;
$mech->get('http://quid.hpl.hp.com:9081/cacti/detailed.y?new');
$mech->submit_form(
    with_fields => {
        'cache_size'=>$total_bytes,#RAM Size (bytes)
		'line_size'=>$_[2],#
		'assoc'=>$_[8],#Associativity 
		'nrbanks'=>1,#Nr. of Banks
		'technode'=>32,
		'rwports'=>0,
		'read_ports'=>$_[3],
		'write_ports'=>$_[4],
		'ser_ports'=>0,#Single Ended Read Ports
		'output'=>$Nr_of_Bits_Read_Out,#Nr. of Bits Read Out
		'changetag'=>1,
		'tagbits'=>$_[7],
		'access_mode'=>0,
		'temp'=>360,#Temperature (300-400 K, steps of 10)
		'data_arr_ram_cell_tech_flavor_in'=>0,
		'data_arr_periph_global_tech_flavor_in'=>0,
		'tag_arr_ram_cell_tech_flavor_in'=>0,
		'tag_arr_periph_global_tech_flavor_in'=>0,
		'interconnect_projection_type_in'=>1,
		'wire_outside_mat_type_in'=>0,
		#'technode'=>64,
		
    }
	#Radiobutton => {}
);
#print result website content to local file
#my $file1 = 'CachebyCacti.html';
open(OUTT,">$_[5]");
print OUTT $mech->content;
close(OUTT);
#get Cache access time by analyse the local file
open(INFOO,$_[5])||die"$!";
my @l1dc=<INFOO>;
close(INFOO);
my $count1=0;
foreach my $neirong1 (@l1dc)
{
  $count1++;
  #print "neirong1\n";
  if ($neirong1=~/Access time/)
  {
    chop $neirong1;
	chop $neirong1;
	chop $neirong1;
	chop $neirong1;
	chop $neirong1;
	my @AccessTime=split(/\s+/,$neirong1);
	my $AccessTime=$AccessTime[4];
	print "$neirong1\n";
	print "So $_[0] Cache Access time is $AccessTime ns.\n";
	$_[6]=$AccessTime;
  }
  if ($neirong1=~/Total area/)
  {
    print "area is $neirong1";
  }
  
  if ($neirong1=~/'!<'/)
  {
    print "error\n";
  }
}
print "$count1 lines in total\n";
if (($count1==160)||($count1==185))
{print"wrong inputs.\n";}

}
