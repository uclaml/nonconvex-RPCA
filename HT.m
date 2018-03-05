function S=HT(S0,k)
[d1,d2]=size(S0);
s=reshape(S0,1,d1*d2);
ss=sort(abs(s),'descend');
judge=ss(k);
if(judge~=0)
[r_ind,c_ind]=find(abs(S0)>judge|abs(S0)==judge);
index=randsample(length(r_ind),k);
S1=S0;
for i=1:length(index)
    S1(r_ind(index(i)),c_ind(index(i)))=0;
end

S=S0-S1;
end
if (judge==0)
S=S0;
end

%S=S0;
%S(abs(S)<(judge))=0;
 %S=wthresh(S0,'h',judge);