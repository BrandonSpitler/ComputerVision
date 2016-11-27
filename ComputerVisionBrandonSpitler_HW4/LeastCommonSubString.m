function [ greatestCommonSubString, curGreatSubStringSize ] = LeastCommonSubString( s1,s2 )
 len_s1=length(s1);
 len_s2=length(s2);
 
 dynArray=zeros(len_s1+1,len_s2+1,2);
 for i=2:1:len_s1+1
     for n =2 :1: len_s2+1
         [dynArray(i,n,1),dir]=max([dynArray(i-1,n-1,1),dynArray(i,n-1,1),dynArray(i-1,n,1)]);
         dynArray(i,n,2)=dir+1;
         if(s1(i-1)==s2(n-1))
             if(dir==1)
                dynArray(i,n,1)=dynArray(i,n,1)+1;
             end
         end
     end
 end
 curGreatSubStringSize=max(max(dynArray(:,:,1)));
i=len_s1+1;
n=len_s2+1;
size=curGreatSubStringSize;
 greatestCommonSubString=blanks(curGreatSubStringSize);
 while(size~=0)
     
     if(dynArray(i,n,2)== 2)
         i=i-1;
         n=n-1;
         
         greatestCommonSubString(size)=s1(i);
         size=size-1;
     elseif(dynArray(i,n,2)==3)
         n=n-1;
     elseif(dynArray(i,n,2)==4)
         i=i-1;
         
     end
     
 end
end

