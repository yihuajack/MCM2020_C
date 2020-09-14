clc,clear

hair_dryer=readtable('hair_dryer.xlsx');
srh=nonzeros(hair_dryer.star_rating');
is_stationary_series_h=adftest(srh);
figure,subplot(121),autocorr(srh);
subplot(122),parcorr(srh);
myaic1=zeros(4);
for i=0:3
    for j=0:3
        if i==0&&j==0
            continue
        end
        m1=armax(srh,[i,j]);
        myaic1(i+1,j+1)=aic(m1);
        fprintf('p=%d,q=%d,AIC=%f\n',i,j,myaic1(i+1,j+1));
    end
end
myaic1(1,1)=inf;
[p1,q1]=find(myaic1==min(min(myaic1)));
m1=armax(srh,[p1-1,q1-1]);
res1=resid(m1,srh);
figure,plot(res1.OutputData);
[h1,pValue1,stat1,cValue1]=lbqtest(res1.OutputData);
ythat1=forecast(m1,srh,6);
% xthat1=srh(end)+cumsum(ythat1);

microwave=readtable('microwave.xlsx');
srm=nonzeros(microwave.star_rating');
is_stationary_series_m=adftest(srm);
figure,subplot(121),autocorr(srm);
subplot(122),parcorr(srm);
myaic2=zeros(4);
for i=0:3
    for j=0:3
        if i==0&&j==0
            continue
        end
        m2=armax(srm,[i,j]);
        myaic2(i+1,j+1)=aic(m2);
        fprintf('p=%d,q=%d,AIC=%f\n',i,j,myaic2(i+1,j+1));
    end
end
myaic2(1,1)=inf;
[p2,q2]=find(myaic2==min(min(myaic2)));
m2=armax(srm,[p2-1,q2-1]);
res2=resid(m2,srm);
figure,plot(res2.OutputData);
[h2,pValue2,stat2,cValue2]=lbqtest(res2.OutputData);
ythat2=forecast(m2,srm,6);
% xthat2=srm(end)+cumsum(ythat2);

pacifier=readtable('pacifier.xlsx');
srp=nonzeros(pacifier.star_rating');
is_stationary_series_p=adftest(srp);
figure,subplot(121),autocorr(srp);
subplot(122),parcorr(srp);
myaic3=zeros(4);
for i=0:3
    for j=0:3
        if i==0&&j==0
            continue
        end
        m3=armax(srp,[i,j]);
        myaic3(i+1,j+1)=aic(m3);
        fprintf('p=%d,q=%d,AIC=%f\n',i,j,myaic3(i+1,j+1));
    end
end
myaic3(1,1)=inf;
[p3,q3]=find(myaic3==min(min(myaic3)));
m3=armax(srp,[p3-1,q3-1]);
res3=resid(m3,srp);
figure,plot(res3.OutputData);
[h3,pValue3,stat3,cValue3]=lbqtest(res3.OutputData);
ythat3=forecast(m3,srp,6);
% xthat3=srp(end)+cumsum(ythat3);

ythat=[ythat1,ythat2,ythat3];
writematrix(ythat,'Reputation_Prediction.csv');