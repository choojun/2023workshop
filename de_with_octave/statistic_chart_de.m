% Bar chart
ages = 20:27; students = [2 1 4 3 2 2 0 1];
%figure(1); bar(ages, students)
axis([19.5 27.5 0 5])
xlabel('age of students '); ylabel('number of students ')
%figure(2); barh(ages, students)
axis([0 5 19.5 27.5])
ylabel('age of students '); xlabel('number of students ')

% Pie chart
strength = [55 52 36 28 13 16];
Labels = {'SVP','SP','FDP','CVP','GR','Div'}
%figure(3); pie(strength)
%figure(4); pie(strength, [0 1 0 0 0 0], Labels)
%figure(5); pie3(strength, Labels)

% 2D Stem chart -  a diagram that quickly summarizes data while maintaining the individual data point.
ii = randi(10, 100, 1); % generate 100 random integers between 1 and 10
[anz, cent] = hist(ii, unique(ii)) % count the events
%figure(6); stem(cent, anz) % generate a 2D stem graph
xlabel('value '); ylabel('number of events '); axis([0 11, -1 max(anz)+1])

% 3D Stem chart
theta = 0:0.2:6;
%figure(7); stem3 (cos (theta), sin (theta), theta);
xlabel('x'); ylabel('y'); zlabel('height ')

% Rose chart - a diagram shows the circular distribution of directional data
% Stair step chart - a diagram is useful for drawing time-history graphs of digitally sampled data.
dataRaw = randi([5 10], 1, 400);
%figure(8); rose(dataRaw, 8) % generate rose plot
title('angular histogram with 8 sectors ')
[data, cent] = hist(dataRaw, unique(dataRaw)) % count the events
%figure(9); stairs(cent, data) % generate stairstep plot
xlabel('value '); ylabel('number of events ');

x = 0:3;
y = 0:2;
z = y' * x;
contour (x, y, z, 2:3)



% Statistic
x
y = sin(x) % generate some artificial data
MeanValues = [mean(x), mean(y)]
Variances = [var(x), var(y)]
StandardDev = [std(x), std(y)]
Covariance = cov(x, y)
Correlation = corr(x, y)

% Statistic with matrix
N = 5
m = rand(N)
mean(m)
var(m)
std(m)
cov(m)
corrcoef(m)

