clc,clear
hair_dryer=readtable('hair_dryer.xlsx');
microwave=readtable('microwave.xlsx');
pacifier=readtable('pacifier.xlsx');
hcomment=table2cell(hair_dryer(:,14));
mcomment=table2cell(microwave(:,14));
pcomment=table2cell(pacifier(:,14));
% hcomment=erase(hcomment,"'");
% mcomment=erase(mcomment,"'");
% pcomment=erase(pcomment,"'");
for i=1:length(hcomment)
    hcomment{i}=strrep(hcomment{i},"<br />","");
    matchStr1=unique(regexp(hcomment{i},'&#\d*','match'));
    matchStr2=unique(regexp(hcomment{i},'[^\x00-\xff]','match'));
    for j=1:length(matchStr1)
        hcomment{i}=strrep(hcomment{i},matchStr1(j),"");
    end
    for j=1:length(matchStr2)
        hcomment{i}=strrep(hcomment{i},matchStr2(j),"");
    end
    % numPunct1(i)=length(isstrprop(hcomment{i},'punct'));
    hair_dryer.review_body{i}=hcomment{i};
end
for i=1:length(mcomment)
    mcomment{i}=strrep(mcomment{i},"<br />","");
    matchStr1=unique(regexp(mcomment{i},'&#\d*','match'));
    matchStr2=unique(regexp(mcomment{i},'[^\x00-\xff]','match'));
    for j=1:length(matchStr1)
        mcomment{i}=strrep(mcomment{i},matchStr1(j),"");
    end
    for j=1:length(matchStr2)
        mcomment{i}=strrep(mcomment{i},matchStr2(j),"");
    end
    % numPunct1(i)=length(isstrprop(mcomment{i},'punct'));
    microwave.review_body{i}=mcomment{i};
end
for i=1:length(pcomment)
    pcomment{i}=strrep(pcomment{i},"<br />","");
    matchStr1=unique(regexp(pcomment{i},'&#\d*','match'));
    matchStr2=unique(regexp(pcomment{i},'[^\x00-\xff]','match'));
    for j=1:length(matchStr1)
        pcomment{i}=strrep(pcomment{i},matchStr1(j),"");
    end
    for j=1:length(matchStr2)
        pcomment{i}=strrep(pcomment{i},matchStr2(j),"");
    end
    % numPunct1(i)=length(isstrprop(pcomment{i},'punct'));
    pacifier.review_body{i}=pcomment{i};
end
writecell(hcomment,'hreview.txt');
writecell(mcomment,'mreview.txt');
writecell(pcomment,'preview.txt');