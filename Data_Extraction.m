clc,clear
fileID1=fopen('Problem_C_Data\hair_dryer.tsv');
fileID2=fopen('Problem_C_Data\microwave.tsv');
fileID3=fopen('Problem_C_Data\pacifier.tsv');
h=textscan(fileID1,'%s %s %s %s %s %s %s %d %d %d %s %s %s %s %s','Delimiter','\t','HeaderLines',1);
m=textscan(fileID2,'%s %s %s %s %s %s %s %d %d %d %s %s %s %s %s','Delimiter','\t','HeaderLines',1);
p=textscan(fileID3,'%s %s %s %s %s %s %s %d %d %d %s %s %s %s %s','Delimiter','\t','HeaderLines',1);
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
h{15}=datetime(h{15},'Format','MM/dd/yyyy');
m{15}=datetime(m{15},'Format','MM/dd/yyyy');
p{15}=datetime(p{15},'Format','MM/dd/yyyy');
for i=1:11470
    if h{11}{i}=='y'||h{11}{i}=='Y'
        h{11}{i}=1;
    elseif h{11}{i}=='n'||h{11}{i}=='N'
        h{11}{i}=0;
    end
    if h{12}{i}=='y'||h{12}{i}=='Y'
        h{12}{i}=1;
    elseif h{12}{i}=='n'||h{12}{i}=='N'
        h{12}{i}=0;
    end
end
for i=1:1615
    if m{11}{i}=='y'||m{11}{i}=='Y'
        m{11}{i}=1;
    elseif m{11}{i}=='n'||m{11}{i}=='N'
        m{11}{i}=0;
    end
    if m{12}{i}=='y'||m{12}{i}=='Y'
        m{12}{i}=1;
    elseif m{12}{i}=='n'||m{12}{i}=='N'
        m{12}{i}=0;
    end
end
for i=1:18939
    if p{11}{i}=='y'||p{11}{i}=='Y'
        p{11}{i}=1;
    elseif p{11}{i}=='n'||p{11}{i}=='N'
        p{11}{i}=0;
    end
    if p{12}{i}=='y'||p{12}{i}=='Y'
        p{12}{i}=1;
    elseif p{12}{i}=='n'||p{12}{i}=='N'
        p{12}{i}=0;
    end
end
save('hair_dryer.mat','h');
save('microwave.mat','m');
save('pacifier.mat','p');
hair_dryer=readtable('hair_dryer.txt','Delimiter','\t');
microwave=readtable('microwave.txt','Delimiter','\t');
pacifier=readtable('pacifier.txt','Delimiter','\t');
hcomment=hair_dryer(:,14);
mcomment=microwave(:,14);
pcomment=pacifier(:,14);
% comment=[hcomment;mcomment;pcomment];
writetable(hcomment,'hcomment.txt');
writetable(pcomment,'mcomment.txt');
writetable(pcomment,'mcomment.txt');
for i=1:11470
    hair_dryer.review_date{i}=datetime(hair_dryer.review_date{i},'Format','MM/dd/yyyy');
    if hair_dryer.vine{i}=='y'||hair_dryer.vine{i}=='Y'
        hair_dryer.vine{i}=1;
    elseif hair_dryer.vine{i}=='n'||hair_dryer.vine{i}=='N'
        hair_dryer.vine{i}=0;
    end
    if hair_dryer.verified_purchase{i}=='y'||hair_dryer.verified_purchase{i}=='Y'
        hair_dryer.verified_purchase{i}=1;
    elseif hair_dryer.verified_purchase{i}=='n'||hair_dryer.verified_purchase{i}=='N'
        hair_dryer.verified_purchase{i}=0;
    end
end
for i=1:1615
    microwave.review_date{i}=datetime(microwave.review_date{i},'Format','MM/dd/yyyy');
    if microwave.vine{i}=='y'||microwave.vine{i}=='Y'
        microwave.vine{i}=1;
    elseif microwave.vine{i}=='n'||microwave.vine{i}=='N'
        microwave.vine{i}=0;
    end
    if microwave.verified_purchase{i}=='y'||microwave.verified_purchase{i}=='Y'
        microwave.verified_purchase{i}=1;
    elseif microwave.verified_purchase{i}=='n'||microwave.verified_purchase{i}=='N'
        microwave.verified_purchase{i}=0;
    end
end
for i=1:18939
    pacifier.review_date{i}=datetime(pacifier.review_date{i},'Format','MM/dd/yyyy');
    if pacifier.vine{i}=='y'||pacifier.vine{i}=='Y'
        pacifier.vine{i}=1;
    elseif pacifier.vine{i}=='n'||pacifier.vine{i}=='N'
        pacifier.vine{i}=0;
    end
    if pacifier.verified_purchase{i}=='y'||pacifier.verified_purchase{i}=='Y'
        pacifier.verified_purchase{i}=1;
    elseif pacifier.verified_purchase{i}=='n'||pacifier.verified_purchase{i}=='N'
        pacifier.verified_purchase{i}=0;
    end
end
writetable(hair_dryer,'hair_dryer.xlsx');
writetable(microwave,'microwave.xlsx');
writetable(pacifier,'pacifier.xlsx');
% hair_dryer=table('Size',[length(h{1}) 15],'VariableTypes',{'string','string','string','string','string',...
%     'string','string','uint8','uint8','uint8','logical','logical','string','string','datetime'},...
%     'VariableNames',{'marketplace','customer_id','review_id','product_id','product_parent',...
%     'product_title','product_category','star_rating','helpful_votes','total_votes','vine',...
%     'verified_purchase','review_headline','review_body','review_date'});
% microwave=table('Size',[length(m{1}) 15],'VariableTypes',{'string','string','string','string','string',...
%     'string','string','uint8','uint8','uint8','logical','logical','string','string','datetime'},...
%     'VariableNames',{'marketplace','customer_id','review_id','product_id','product_parent',...
%     'product_title','product_category','star_rating','helpful_votes','total_votes','vine',...
%     'verified_purchase','review_headline','review_body','review_date'});
% pacifier=table('Size',[length(p{1}) 15],'VariableTypes',{'string','string','string','string','string',...
%     'string','string','uint8','uint8','uint8','logical','logical','string','string','datetime'},...
%     'VariableNames',{'marketplace','customer_id','review_id','product_id','product_parent',...
%     'product_title','product_category','star_rating','helpful_votes','total_votes','vine',...
%     'verified_purchase','review_headline','review_body','review_date'});
% for i=1:15
%     for j=1:length(h{1})
%         hair_dryer(j,i)=h{i}{j};
%     end
%     for j=1:length(m{1})
%         microwave(j,i)=m{i}{j};
%     end
%     for j=1:length(p{1})
%         pacifier(j,i)=p{i}{j};
%     end
% end