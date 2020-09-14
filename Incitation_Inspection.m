clc,clear
lrrh=readtable('Book1.xlsx','Sheet','hair_dryer');
lrrm=readtable('Book1.xlsx','Sheet','microwave');
lrrp=readtable('Book1.xlsx','Sheet','pacifier');
hair_dryer=readtable('hair_dryer.xlsx');
microwave=readtable('microwave.xlsx');
pacifier=readtable('pacifier.xlsx');
eah=readtable('Emotion_Analysis\Hair_Dryer_Emotion_Analysis.txt');
eam=readtable('Emotion_Analysis\Microwave_Emotion_Analysis.txt');
eap=readtable('Emotion_Analysis\Pacifier_Emotion_Analysis.txt');
len1=length(hair_dryer.review_id);
slen1=length(lrrh.review_id);
t1=0;
for i=1:len1
    for j=1:slen1
        if strcmp(hair_dryer.review_id{i},lrrh.review_id{j})
            t1=t1+1;
            index1(t1)=i;
        end
    end
end
for i=1:t1
    if index(i-5)>0
        flag1(i)=mean(eah(index1(i),2):eah(index1(i-5),2));
    end
end
insmean1=mean(flag1);
writematrix([insmean1],'Incitation_Inspection.txt');