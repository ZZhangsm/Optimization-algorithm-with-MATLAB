function [L, D]=Cholesky(A)
%Cholesky分解 A=L*D*L'
n = length(A);
L = eye(n);
C = zeros(n);D = zeros(n);
for j=1:n
    h1 = 0;
    for s=1:j-1
        h1 = h1 + D(s,s)*L(j,s)^2;
    end
    C(j,j) = A(j,j)- h1;
    D(j,j) = C(j,j);
    %可于此处修正
    
    for i=j+1:n
        h2 = 0;
        for m=1:j-1
            h2 = h2+ D(m,m)*L(i,m)*L(j,m);
        end
        C(i,j) = A(i,j)- h2;
        L(i,j) = C(i,j)/D(j,j);
    end
end
end
        
        


