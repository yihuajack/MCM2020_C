clc,clear
hair_dryer=readtable('Review_Analysis\hair_dryer_cleaned.txt');
microwave=readtable('Review_Analysis\microwave_cleaned.txt');
pacifier=readtable('Review_Analysis\pacifier_cleaned.txt');
rrh=readcell('Review_Readability\Hair_Dryer_Review_Readability.txt');
rrm=readcell('Review_Readability\Microwave_Review_Readability.txt');
rrp=readcell('Review_Readability\Pacifier_Review_Readability.txt');

w1=zeros(1,length(rrh));
for i=1:length(rrh)
    w1(i)=hair_dryer.star_rating(i)-1/6*hair_dryer.star_rating(i)^2+...
        1/3*log(length(hair_dryer.review_body(i)))+0.5*log(hair_dryer.total_votes(i)+1)+...
        +2*hair_dryer.vine(i)+0.01*rrh{i}+1/3*(hair_dryer.review_date(i).Year-2012);
end
[b1,i1]=sort(w1);
top_reviews_h=hair_dryer.review_body(i1(end-10:end));

w2=zeros(1,length(rrm));
for i=1:length(rrm)
    w2(i)=microwave.star_rating(i)-1/6*microwave.star_rating(i)^2+...
        1/3*log(length(microwave.review_body(i)))+0.5*log(microwave.total_votes(i)+1)+...
        +2*microwave.vine(i)+0.01*rrm{i}+1/3*(microwave.review_date(i).Year-2012);
end
[b2,i2]=sort(w2);
top_reviews_m=microwave.review_body(i2(end-10:end));

w3=zeros(1,length(rrp));
for i=1:length(rrp)
    w3(i)=pacifier.star_rating(i)-1/6*pacifier.star_rating(i)^2+...
        1/3*log(length(pacifier.review_body(i)))+0.5*log(pacifier.total_votes(i)+1)+...
        +2*pacifier.vine(i)+0.01*rrp{i}+1/3*(pacifier.review_date(i).Year-2012);
end
[b1,i1]=sort(w3);
top_reviews_p=pacifier.review_body(i1(end-10:end));

writecell(top_reviews_h,'Hair_Dryer_Review_Top10.txt');
writecell(top_reviews_m,'Microwave_Review_Top10.txt');
writecell(top_reviews_p,'Pacifier_Review_Top10.txt');