function y=rfft(x,n,d)
%RFFT     Calculate the DFT of real data Y=(X,N,D)
% Data is truncated/padded to length N if specified.
%   N even:	(N+2)/2 points are returned with
% 			the first and last being real
%   N odd:	(N+1)/2 points are returned with the
% 			first being real
% In all cases fix(1+N/2) points are returned
% D is the dimension along which to do the DFT


s=size(x);
if prod(s)==1
    y=x
else
    if nargin <3 || isempty(d)
        d=find(s>1);
        d=d(1);
        if nargin<2
            n=s(d);
        end
    end
    if isempty(n) 
        n=s(d);
    end
    y=fft(x,n,d);
    y=reshape(y,prod(s(1:d-1)),n,prod(s(d+1:end))); 
    s(d)=1+fix(n/2);
    y(:,s(d)+1:end,:)=[];
    y=reshape(y,s);
end