X = [1 1;1 2; 1 3;2 1;2 2;2 3;3 1;3 2;3 3]
Nodes  = [-0.45 0.1;0.18 0.55;0.65 -0.12;0.2 -0.35;0.3 0.07;0.15 -0.20;-0.02 -0.05;-0.25 -0.08;0.44 0.45];

for i=1:size(X,1)
    % Calculate Euclidean distance between a sample X and all nodes
    E_distance = sum( (ones(size(Nodes,1),1)*X(i,:)- Nodes) . ^2,2) . ^(0.5)
end
