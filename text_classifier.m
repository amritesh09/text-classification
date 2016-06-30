data = textread('data.txt', '%s', 'delimiter', '\n','bufsize',64000);


for i=1:7230
x{i}=textscan(data{i},'%s');
end

%% now x{}{1}{} contaions all words

for i=1:7230
words2{i}=x{i}{1};
end

%now words{}{} contains all words


%get unique words that form feature vector

wordvector=vertcat(words2{:});  %create vector of all words

uwords=unique(wordvector);	%uwords contains unique words


%get frequency of each word freq[][] in each article

%use sum((strcmp(words2{1},'auto'))) for all in a article 

freq{7320}{37061}='';			%create freq matrix to store frequency of each word in each article
%This will take some time

 freqarr=repmat(uint8(0),37061,7230);
 for i=1:7280
       for j=1:37061
          freq{i}{j}=sum((strcmp(words2{i},uwords{j}))) ;    % freq[i][j] represent freq of jth word in ith article
        end
			i
end

freqarr(i,j)=sum((strcmp(words2{i},uwords{j}))) ;    % freqarr[i][j] represent freq of jth word in ith article

%%Now divide data into 5 training sets
%%12000 random nos between 1 and 7230
	 r = 1 + (7229).*rand(12000,1);
%% convert to int
	r1=uint16(r);

%% unique training sets out of them	
j=1;i=1;

while(j<1446)
while(track(r1(i))==1)
	i=i+1;
	end
	
ts1(j)=r1(i);
track(r1(i))=1;
i=i+1;
j=j+1;

end

%% for training set 4
 j=1;

while(j<1448)
while(track(r1(i))==1)
	i=i+1;
	end
	
ts4(j)=r1(i);
track(r1(i))=1;
i=i+1;
j=j+1;

end
%% for training set 5
for i=1:7230
if(track(i)==0)
ts5(j)=i;
track(i)=1;
end
end

%% replace class name with class id
 for i=1:989
words2{1,i}{1,1}=1;
end
 for i=990:1985
words2{1,i}{1,1}=2;
end
for i=1986:2979
words2{1,i}{1,1}=3;
end
 for i=2980:3978
words2{1,i}{1,1}=4;
end
  for i=3979:4887
words2{1,i}{1,1}=5;
end
  for i=4887:5827
words2{1,i}{1,1}=6;
end
  for i=5828:6602
words2{1,i}{1,1}=7;
end
   for i=6603:7230
words2{1,i}{1,1}=8;
   end

%%find mean and var for ts1,ts2,ts3,ts4
 ts1235=[ts1,ts2,ts3,ts4];
 ts1235=[ts1,ts2,ts3,ts5];
 ts1245=[ts1,ts2,ts4,ts5];
 ts1345=[ts1,ts3,ts4,ts5];
 ts2345=[ts2,ts3,ts4,ts5];

%%freqc1ts1235 stores freq of all articles having class1 in ts1235
freqarr=freqarr-1;

c=1;
for i=1:5783
   if(words2{1,ts1235(i)}{1,1}==1)
   freqc1ts1235(c,:)=uint8(not(not(freqarr(ts1235(i),:))));
   c=c+1;
end     
end
c=1;
for i=1:5783
   if(words2{1,ts1235(i)}{1,1}==2)
   freqc2ts1235(c,:)=uint8(not(not(freqarr(ts1235(i),:))));
   c=c+1;
   end   
end
c=1;
for i=1:5783
   if(words2{1,ts1235(i)}{1,1}==3)
   freqc3ts1235(c,:)=uint8(not(not(freqarr(ts1235(i),:))));
   c=c+1;
end     
end
c=1;
for i=1:5783
   if(words2{1,ts1235(i)}{1,1}==4)
   freqc4ts1235(c,:)=uint8(not(not(freqarr(ts1235(i),:))));
   c=c+1;
end     
end
c=1;
for i=1:5783
   if(words2{1,ts1235(i)}{1,1}==5)
   freqc5ts1235(c,:)=uint8(not(not(freqarr(ts1235(i),:))));
   c=c+1;
end     
end
c=1;
for i=1:5783
   if(words2{1,ts1235(i)}{1,1}==6)
   freqc6ts1235(c,:)=uint8(not(not(freqarr(ts1235(i),:))));
   c=c+1;
end     
end
c=1;
for i=1:5783
   if(words2{1,ts1235(i)}{1,1}==7)
   freqc7ts1235(c,:)=uint8(not(not(freqarr(ts1235(i),:))));
   c=c+1;
end     
end
c=1;
for i=1:5783
   if(words2{1,ts1235(i)}{1,1}==8)
   freqc8ts1235(c,:)=uint8(not(not(freqarr(ts1235(i),:))));
   c=c+1;
end     
end
%% PRIORS
probc1=size(freqc1ts1235,1)/5783;
probc2=size(freqc2ts1235,1)/5783;
probc3=size(freqc3ts1235,1)/5783;
probc4=size(freqc4ts1235,1)/5783;
probc5=size(freqc5ts1235,1)/5783;
probc6=size(freqc6ts1235,1)/5783;
probc7=size(freqc7ts1235,1)/5783;
probc8=size(freqc8ts1235,1)/5783;
probc(1)=probc1;
probc(2)=probc2;
probc(3)=probc3;
probc(4)=probc4;
probc(5)=probc5;
probc(6)=probc6;
probc(7)=probc7;
probc(8)=probc8;
%{     
 FOR GAUSSIAN DISTRIBUTION
deviance = bsxfun(@minus,double(freqarr(7223,:)),meanc());  %tbc
deviance = bsxfun(@rdivide,deviance,var); %tbc
deviance = deviance .^ 2; %tbc
deviance = bsxfun(@plus,deviance,2*log(abs(var))); %tbc
deviance = deviance + log(2*pi);  %not necessary here, actually;
[dummy,mini] = min(deviance,[],2);  %find which class;


for k=1:1446
    for i=1:8
        pc(i)=log(probc(i));
        for j=1:37061
                if(not(freqarr(ts5(k),j)==0)&&not(var(i,j)==0))
                x=exp(-(((double(freqarr(2,j))-meanc(i,j))/var(i,j))^2)/2);
                if(x==0)
                    x=1;
                end
                y=1/((2*pi*var(i,j)^2)^0.5);
                if(y==0)
                    y=1;end
               if(not(isnan(x))&&not(isnan(y))&&not(isinf(x))&&not(isinf(y)))
            pc(i)=pc(i)+log(abs(y))+log(abs(x)) ;
            [d m]=max(pc);
                    end
                end
        end
    end
    result(k,1)=words2{1,ts5(k)}{1,1};
    result(k,2)=m;
end


%%results CM IS THE CONFUSION MATRIX
for i=1:1446
for j=1:2
cm(result(i,1),result(i,2))=cm(result(i,1),result(i,2))+1;
end
end
%}

%   BERNAULLI DISTribution
% Laplacian correction
 freqc1ts1235=freqc1ts1235+1;
freqc2ts1235=freqc2ts1235+1;
 freqc3ts1235=freqc3ts1235+1;
 freqc4ts1235=freqc4ts1235+1;
 freqc5ts1235=freqc5ts1235+1;
 freqc6ts1235=freqc6ts1235+1;
 freqc7ts1235=freqc7ts1235+1;
 freqc8ts1235=freqc8ts1235+1;
 freqarr=freqarr+1;

 %bprob stores probability of occurrence of each word in each class
for j=1:37061
bprob(1,j)=sum(freqc1ts1235(:,j))/(2*780);
end

for j=1:37061
bprob(2,j)=sum(freqc2ts1235(:,j))/(2*811);
end


for j=1:37061
bprob(3,j)=sum(freqc3ts1235(:,j))/(2*808);
end

for j=1:37061
bprob(4,j)=sum(freqc4ts1235(:,j))/(2*787);
end

for j=1:37061
bprob(5,j)=sum(freqc5ts1235(:,j))/(2*717);
end

for j=1:37061
bprob(6,j)=sum(freqc6ts1235(:,j))/(2*748);
end

for j=1:37061
bprob(7,j)=sum(freqc7ts1235(:,j))/(2*629);
end

for j=1:37061
bprob(8,j)=sum(freqc8ts1235(:,j))/(2*503);
end





 %research%
 %REMOVE STOP WORDS
 stopwords = textread('stopwords.txt', '%s', 'delimiter', '\n','bufsize',6400);
 for i=1:37061
for j=1:635
if(strcmp(uwords{i,1},stopwords{j,1}))
bprob(:,i)=0.5000;
end
end
 end

% TEST ON TRAINING SET 5
for k=1:1447
    for i=1:8
        pc(i)=log(probc(i));%probc is probability of class i
        for j=1:37061
               if(freqarr(ts4(k),j)>=2)
               x=double(2*bprob(i,j));%+(double((2-freqarr(ts5(k),j)))*(1-bprob(i,j))));
               %x is probability of given value of feature vector in class i
               else x=0;
               
        end
               if(not(x==0))
                    pc(i)=pc(i)+log(x);
                %Bayes theorem
               end
        end
        %pc(i)=pc(i)*probc(i);
           [d m]=max(pc);
       
    end
    result(k,1)=words2{1,ts4(k)}{1,1};
    result(k,2)=m;
   
end

% CM IS THE CONFUSION MATRIX
clear cm;
cm(8,8)=0;
 for i=1:1446
cm(result(i,1),result(i,2))=cm(result(i,1),result(i,2))+1;
 end
 
 accuracy=sum(diag(cm))/sum(sum(cm))*100
 

 
%calculate sumfreq
 clear sumfreq;
sumfreq(8,37061)=0;
sumfreq(1,:)=sum(freqc1ts1235,1);
sumfreq(1,:)=sumfreq(1,:)-780;
sumfreq(2,:)=sum(freqc2ts1235,1)-811;
sumfreq(3,:)=sum(freqc3ts1235,1)-808;
sumfreq(4,:)=sum(freqc4ts1235,1)-787;
sumfreq(5,:)=sum(freqc5ts1235,1)-717;
sumfreq(6,:)=sum(freqc6ts1235,1)-748;
sumfreq(7,:)=sum(freqc7ts1235,1)-629;
sumfreq(8,:)=sum(freqc8ts1235,1)-503;


%remove stopwords
for i=1:37061
for j=1:635
if(strcmp(uwords{i,1},stopwords{j,1}))
sumfreq(:,i)=0;
end
end
end

%calculate mean frequency
clear mean;
mean=mean(sumfreq,1);

%words with deviation more than 6 times the mean
c=0;
for i=1:8
for j=1:37061
if(sumfreq(i,j)-mean(j)>(mean(j)*6)&&sumfreq(i,j)>10)
bprob(i,j)=bprob(i,j)*sumfreq(i,j);
end
end
end
%accuracy 99.2393




for i=1:8
cnt=1;
for j=1:648
    if(not(uniquewordsinclass(i,j))==0)
hundredgoldenwords(cnt)=uniquewordsinclass(i,j);
cnt=cnt+1;
    end
if(rem(cnt,12)==0)
continue;
end
end
end

for i=1:8
for cnt=1:100
    if(not(sumfreq(i,hundredgoldenwords(cnt)))==0)
bprob(i,hundredgoldenwords(cnt))=bprob(i,hundredgoldenwords(cnt))*sumfreq(i,hundredgoldenwords(cnt));
end
end
end

for k=1:1447
    for i=1:8
        pc(i)=log(probc(i));%probc is probability of class i
        for j=1:37061
               if(freqarr(ts4(k),j)>=2)
               x=double(2*bprob(i,j));%+(double((2-freqarr(ts5(k),j)))*(1-bprob(i,j))));
               %x is probability of given value of feature vector in class i
               else x=0;
               
        end
               if(not(x==0))
                    pc(i)=pc(i)+log(x);
                %Bayes theorem
               end
        end
        %pc(i)=pc(i)*probc(i);
           [d m]=max(pc);
       
    end
    result(k,1)=words2{1,ts4(k)}{1,1};
    result(k,2)=m;
   
end

% CM IS THE CONFUSION MATRIX
clear cm;
cm(8,8)=0;
 for i=1:1447
cm(result(i,1),result(i,2))=cm(result(i,1),result(i,2))+1;
 end
 
 accuracy=sum(diag(cm))/sum(sum(cm))*100
 
 
 %%modified code for using only golden words 
 j2=1;
for i=1:8
    for j=1:37061
        
        if(sumfreq(i,j)-mean(j)>=(mean(j)*6)&&sumfreq(i,j)>10)
        freqarrmod(:,j2)=freqarr(:,j);
        j2=j2+1;
         end
    end
end
 j2=1;
for i=1:8
    for j=1:37061
        
        if(sumfreq(i,j)-mean(j)>=(mean(j)*6)&&sumfreq(i,j)>10)
        bprobmod(:,j2)=bprob(:,j);
        j2=j2+1;
         end
    end
end

for k=1:1447
    for i=1:8
        pc(i)=log(probc(i));%probc is probability of class i
        for j=1:902
               if(freqarrmod(ts4(k),j)>=2)
               x=double(2*bprobmod(i,j));%+(double((2-freqarr(ts5(k),j)))*(1-bprob(i,j))));
               %x is probability of given value of feature vector in class i
               else x=0;
               
        end
               if(not(x==0))
                    pc(i)=pc(i)+log(x);
                %Bayes theorem
               end
        end
        %pc(i)=pc(i)*probc(i);
           [d m]=max(pc);
       
    end
    result(k,1)=words2{1,ts4(k)}{1,1};
    result(k,2)=m;
   
end

% CM IS THE CONFUSION MATRIX
clear cm;
cm(8,8)=0;
 for i=1:1447
cm(result(i,1),result(i,2))=cm(result(i,1),result(i,2))+1;
 end
 
 accuracy=sum(diag(cm))/sum(sum(cm))*100
 

 