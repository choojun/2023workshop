% Optimizing f(x)=x^2 within a range [0, 63]
clear;
rand('seed',70);
crossover_prob = 0.90;
mutation_prob  = 0.05;
Max_gen        = 20;
highest_f      = 63^2;
generation     = 0;

% Track best individual and display convergence
figure(1);
Best(generation+1) = 0;
plot(Best); xlabel('Generation'); ylabel('Fitness Values');
grid on
title('Fitness Values of Each Generation');
text(0.5, 0.95, ['Last value = ', num2str(Best(generation+1))], 'Units', 'normalized');
drawnow;

% Step 1 - generate an initial population
Ch = rand(6,6)>0.5;

for g=1:Max_gen
    % Step 2 - evaluate fitness
    Ch_str    = num2str(Ch);
    x         = bin2dec(Ch_str);
    fitness_v = x.^2;
    best_fit  = max(fitness_v);
    if (best_fit == highest_f)| all(x==0)
        break;
    end

    % Step 3a - selection
    [Selected_C] = roulette(Ch,fitness_v);

    % Step 3b - point crossover
    for i=1:size(Selected_C,2)/2
        ps   = [];
        ps   = randperm(size(Selected_C,2));
        h_id = find(ps==size(Selected_C,2));
        ps(h_id) = [];
        l_id = find(ps==1);
        ps(l_id) = [];
        ap   = ps(1);

        if rand(1)<=crossover_prob
            New_Ch(2*i-1,:) = [Selected_C(2*i-1,1:ap) Selected_C(2*i,(ap+1):end)];
            New_Ch(2*i,:)   = [Selected_C(2*i,1:ap) Selected_C(2*i-1,(ap+1):end)];
        else
            New_Ch(2*i-1,:) = Ch(2*i-1,:);
            New_Ch(2*i,:)   = Ch(2*i,:);
        end
    end

    % Step 3c - mutation
    if rand(1)<=mutation_prob
        iid = randperm(size(New_Ch,1));
        jid = randperm(size(New_Ch,2));

        if New_Ch(iid,jid)== 0
             New_Ch(iid,jid) = 1;
        else
             New_Ch(iid,jid) = 0;
        end
    end

    % Step 4 -  replace with new chromosomes
    Ch = New_Ch;
    generation = generation+1;

    % Update display and record current best individual
    figure(1);
    Best(generation+1) = best_fit;
    plot(Best); xlabel('Generation'); ylabel('Fitness Values');
    grid on
    title('Fitness Values of Each Generation');
    text(0.5, 0.95, ['Last value = ', num2str(Best(generation+1))], 'Units', 'normalized');
    drawnow;

end
