a=[0.2 0.3;0.6 0.7];
A=[a 1-a];
w=[1 1 1 1;1 1 1 1];
status(1:2) = 2;

alpha = 0;
beta  = 1;
rho   = 0.70;

for i=1:size(a,1)
    learned  =0;
    while (1)
        while(1)
            %Computation Tj
            Numerator   = min(ones(2,1)*A(i,:),w);
            Denominator = sum(w,2);
            T           = sum(Numerator,2)./Denominator;

            id    = find(status==0);
            T(id) = -1;
            %Select winning node
            [x J] = max(T);
            if status(J)~=0
                break;
            end
        end

        print_i(i) = i
        print_sample(i,:) = A(i,:)
        print_T(i)        = T(J)
        print_winner(i)   = J
        print_wold(i,:)   = w(J,:);

        %Vigilance test
        result = sum(min(A(i,:),w(J,:)))/sum(A(i,:));
        if result>=rho
            %Learning
            w(J,:) = beta*(min(A(i,:),w(J,:)))+ (1-beta)*w(J,:);
            status(J)=1;
            learned  =1;
            print_wnew(i,:)   = w(J,:)
        else
            status(J)=0
        end

        if learned
            %%%%%%%%%%%%%%%%
            % print output
            %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No_sample  X                 Winning_HNode   T(J)        Vigilance_Test  UpdateWeight
%print_i(i) print_sample(i,:) print_winner(i) print_T(i)  status(J)       print_wnew(i,:)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            break;
        end
    end
end
