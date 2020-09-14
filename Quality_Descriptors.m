clc,clear
hair_dryer=readtable('hair_dryer.xlsx');
microwave=readtable('microwave.xlsx');
pacifier=readtable('pacifier.xlsx');
hcomment=table2cell(hair_dryer(:,14));
mcomment=table2cell(microwave(:,14));
pcomment=table2cell(pacifier(:,14));

qdh1=[];
qdh2=[];
th1=1;
th2=1;
for i=1:length(hcomment)
    if contains(hcomment{i},["great","perfect","best","like","love","excellent","wonderful","satisf","enthusia","willing","useful","helpful","nice"])
        qdh1(th1)=hair_dryer.star_rating(i);
        th1=th1+1;
    end
    if contains(hcomment{i},["not good","bad","terrible","worst","horrible","disgust","dislike","dissatisf","disappoint","not recommend","not fit","doesn"])
        qdh2(th2)=hair_dryer.star_rating(i);
        th2=th2+1;
    end
end
positive1=mean(qdh1);
negative1=mean(qdh2);

qdm1=[];
qdm2=[];
tm1=1;
tm2=1;
for i=1:length(mcomment)
    if contains(mcomment{i},["great","perfect","best","like","love","excellent","wonderful","satisf","enthusia","willing","useful","helpful","nice"])
        qdm1(tm1)=microwave.star_rating(i);
        tm1=tm1+1;
    end
    if contains(mcomment{i},["not good","bad","terrible","worst","horrible","disgust","dislike","dissatisf","disappoint","not recommend","not fit","doesn"])
        qdm2(tm2)=microwave.star_rating(i);
        tm2=tm2+1;
    end
end
positive2=mean(qdm1);
negative2=mean(qdm2);

qdp1=[];
qdp2=[];
tp1=1;
tp2=1;
for i=1:length(pcomment)
    if contains(pcomment{i},["great","perfect","best","like","love","excellent","wonderful","satisf","enthusia","willing","useful","helpful","nice"])
        qdp1(tp1)=pacifier.star_rating(i);
        tp1=tp1+1;
    end
    if contains(pcomment{i},["not good","bad","terrible","worst","horrible","disgust","dislike","dissatisf","disappoint","not recommend","not fit","doesn"])
        qdp2(tp2)=pacifier.star_rating(i);
        tp2=tp2+1;
    end
end
positive3=mean(qdp1);
negative3=mean(qdp2);

writematrix([positive1,negative1;positive2,negative2;positive3,negative3],'Quality_Descriptors.txt')