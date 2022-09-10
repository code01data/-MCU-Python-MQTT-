x = load('1.txt')  %璇诲彇1.txt鏂囦欢鐨勬暟鎹�
x_sort = sort(x)   %鎸夌収浠庡皬鍒板ぇ鎺掑簭
dlmwrite('2.txt',x_sort)%  鎶婂彉閲忓啓鍏ュ埌2.txt鏂囦欢
%{
鍑芥暟璇�娉�
dlmwrite(filename, M)
dlmwrite(filename, M, 'D')
dlmwrite(filename, M, 'D', R, C)
dlmwrite(filename, M, 'attrib1', value1, 'attrib2', value2, ...)
dlmwrite(filename, M, '-append')
dlmwrite(filename, M, '-append', attribute-value list) 

鍙傛暟瑙ｆ瀽
dlmwrite(filename, M)
鐢ㄩ粯璁ょ殑鍒嗛殧绗�(閫楀彿)灏嗘暣涓�鐭╅樀M鍐欏埌鏂囦欢鍚嶄负filename鐨勬枃鏈�鏂囦欢涓�
dlmwrite(filename, M, 'D')
鐢ㄥ垎闅旂��D(缂虹渷涓洪€楀彿锛屽埗琛ㄧ�﹀彲浠ョ敤\t琛ㄧず)灏嗘暣涓�鐭╅樀M鍐欏埌filename鏂囦欢涓�
dlmwrite(filename, M, 'D', R, C)
鐢ㄥ垎闅旂��D灏嗛儴鍒嗙煩闃礛鍐欏埌filename鏂囦欢涓�锛氫粠鐭╅樀鐨勭�琑琛岋紝绗珻鍒楀紑濮嬪啓鍒版枃浠朵腑锛圧銆丆浠庨浂寮€濮嬭�＄畻锛夈€�

dlmwrite(filename, M, 'attrib1', value1, 'attrib2', value2, ...) 
鎸変竴瀹氱殑閫夐」灏嗙煩闃礛鍐欏埌filename鏂囦欢涓�锛屽叾涓璦ttrib1鍜寁alue1涓哄睘鎬у�癸紝灞炴€у�瑰弬鐪嬩笅琛ㄣ€�

灞炴€�					灞炴€у€�

delimiter		鍒嗛殧绗�,鐢ㄦ潵灏嗙煩闃典腑鐩搁偦涓や釜鍏冪礌鍒嗛殧寮€
newline			newline鐨勫彲閫夊€间负'pc'鍜�'unix'锛岃�ュ睘鎬т笌姣忚�岀殑缁撴潫绗︽湁鍏炽€俷ewline涓�'pc'鏃讹紝姣忚�屼互\r\n(鍥炶溅鎹㈣��)缁撴潫锛屼负'unix'鏃讹紝姣忚�屼互\n(鎹㈣��)缁撴潫銆�
roffset			杈撳嚭鐨勭煩闃垫暟鎹�鍓嶉潰鎵€鍔犵殑绌鸿�屾暟
coffset			杈撳嚭鐨勭煩闃垫暟鎹�鍓嶉潰鎵€鍔犵殑绌哄垪鏁�
precision		杈撳嚭鐨勭煩闃垫暟鎹�鐨勭簿搴︼紝鎸囧畾鏁版嵁鐨勬湁鏁堟暟浣嶆垨浠�C璇�瑷€椋庢牸鐨勬牸寮忚緭鍑猴紙浠�%寮€濮嬶紝濡�'%10.5f'锛�

dlmwrite(filename, M, '-append') 
鍦ㄦ枃浠剁殑鏈�绔�杈撳嚭鐭╅樀M銆傚�傛灉娌℃湁鎸囧畾-append閫夐」锛宒lmwrite浼氳�嗙洊宸茬粡瀛樺湪鐨勬枃浠躲€�

dlmwrite(filename, M, '-append', attribute-value list) 

鍏佽�镐娇鐢ㄥ睘鎬у�瑰垪琛ㄣ€�
%}







渚�1:锛�

FileName='Data_dlmwrite.txt';

M=rand(4);

dlmwrite(FileName, M, 'delimiter' , '\t' , 'precision', 6)        
%灏嗙煩闃礛瀵煎嚭鍒癋ileName鏂囦欢涓�锛屽垎闅旂�︿负鍒惰〃绗︼紝鏈夋晥鏁颁綅涓�6浣嶃€�

type(FileName)

 

渚�2:锛�

FileName='Data_dlmwrite.txt';

M=rand(4);

dlmwrite(FileName, M, 'precision', '%.6f', 'newline', 'pc')        
%灏嗙煩闃礛瀵煎嚭鍒癋ileName鏂囦欢涓�锛屽垎闅旂�︿负榛樿�ょ殑閫楀彿锛屽皬鏁扮偣鍚庨潰淇濈暀鍏�浣嶏紝姣忚�屼互\r\n缁撴潫銆�

type(FileName)        %鍙�浠ヨ瘯涓€涓嬩笂闈㈢殑newline灞炴€ф敼涓簎nix鍐嶇敤璁颁簨鏈�鎵撳紑璇ユ枃浠�

 

渚�3:锛�

FileName='Data_xlmwrite.txt';                %鏂囦欢鍚�

M = magic(3);

dlmwrite(FileName, [M*5 M/5], ' ')            %鐢╠lmwrite鍑芥暟鍏堟妸鏁版嵁(涓夎�屽叚鍒�)鍐欏埌鏂囦欢,鍒嗛殧绗︿负绌烘牸

type(FileName)                                %鍏堟樉绀轰竴娆�FileName鐨勫唴瀹�

dlmwrite(FileName, [M/3], '-append', 'roffset', 1, 'delimiter', ' ')       
 %鍐嶇敤dlmwrite寰€鏂囦欢鐨勬湭绔�娣诲姞鏁版嵁(涓夎�屼笁鍒�)(append浠ｈ〃娣诲姞,roffset浠ｈ〃娣诲姞涓€琛岀┖琛�,delimiter浠ｈ〃鍒嗛殧绗︿负绌烘牸)

type(FileName)                                %鍐嶆樉绀轰竴娆℃洿鏂板悗鐨凢ileName鐨勫唴瀹�

dlmread(FileName)                            %鐢╠lmread鍑芥暟杞藉叆鏂囦欢,浼氬彂鐜板悗涓夎�岀殑鍚庝笁鍒楄ˉ闆跺�勭悊