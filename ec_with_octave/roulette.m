% roulette wheel selection
function [Selected_C] = roulette(C,f);
nC = size(C,1);

sum_f = sum(f); %total pie
p     = f./sum_f;

k     = 0;
for i=1:nC
    k = k+p(i);   %to calculate the cummulative probability
    cp(i)=k;      %cumulative probability stored. Cummulative probality of the last value should be 1
end

spointer = rand(1,nC);
for i=1:nC
    for j=1:nC
        if (cp(j)>=spointer(i))
            Selected_C(i,:) = C(j,:);
            break;
        end
    end
end
