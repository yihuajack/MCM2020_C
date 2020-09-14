clc,clear
hair_dryer=readtable('hair_dryer.xlsx');
microwave=readtable('microwave.xlsx');
pacifier=readtable('pacifier.xlsx');
ymtemp1=datevec(hair_dryer.review_date);
ymtemp2=datevec(microwave.review_date);
ymtemp3=datevec(pacifier.review_date);
datetemp1=12*ymtemp1(:,1)+ymtemp1(:,2);
datetemp2=12*ymtemp2(:,1)+ymtemp2(:,2);
datetemp3=12*ymtemp3(:,1)+ymtemp3(:,2);
[dategroup1,ia1,ib1]=unique(datetemp1);
[dategroup2,ia2,ib2]=unique(datetemp2);
[dategroup3,ia3,ib3]=unique(datetemp3);
srh_mean=zeros(1,length(ia1));
srm_mean=zeros(1,length(ia2));
srp_mean=zeros(1,length(ia3));
rdh_center=zeros(length(ia1),6);
rdm_center=zeros(length(ia2),6);
rdp_center=zeros(length(ia3),6);
for i=1:length(ia1)-1
    srh_mean(end-i+1)=mean(hair_dryer.star_rating(ia1(end-i+1):ia1(end-i)-1));
    rdh_center(i+1,:)=ymtemp1(fix((ia1(i)+ia1(i+1))/2),:);
end
srh_mean(1)=mean(hair_dryer.star_rating(ia1(1)));
rdh_center(1,:)=ymtemp1(ia1(1),:);
for i=1:length(ia2)-1
    srm_mean(end-i+1)=mean(microwave.star_rating(ia2(end-i+1):ia2(end-i)-1));
    rdm_center(i+1,:)=ymtemp2(fix((ia2(i)+ia2(i+1))/2),:);
end
srm_mean(1)=mean(microwave.star_rating(ia2(1)));
rdm_center(1)=ymtemp2(ia2(1));
for i=1:length(ia3)-1
    srp_mean(end-i+1)=mean(pacifier.star_rating(ia3(end-i+1):ia3(end-i)-1));
    rdp_center(i+1,:)=ymtemp3(fix((ia3(i)+ia3(i+1))/2),:);
end
srp_mean(1)=mean(pacifier.star_rating(ia3(1)));
rdp_center(1)=ymtemp3(ia3(1));
% datenum1=datenum(rdh_center);
% datenum2=datenum(rdm_center);
% datenum3=datenum(rdp_center);
ax1=subplot(3,1,1);
plot(datetime(rdh_center),srh_mean,'DatetimeTickFormat','MMM, yyyy');
% dateaxis('x',12);
title(ax1,'Hair_dryer','Interpreter','none');
% set(gca,'YLim',[0 5]);
ax2=subplot(3,1,2);
plot(datetime(rdm_center),srm_mean,'DatetimeTickFormat','MMM, yyyy');
% dateaxis('x',12);
title(ax2,'Microwave');
% set(gca,'YLim',[0 5]);
ax3=subplot(3,1,3);
plot(datetime(rdp_center),srp_mean,'DatetimeTickFormat','MMM, yyyy');
% dateaxis('x',12);
title(ax3,'Pacifier');
% set(gca,'YLim',[0 5]);