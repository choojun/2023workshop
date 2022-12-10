includepaths;
f = @(x) dtlz_range('dtlz1', 2);
xrange = dtlz_range('dtlz1', 2);
[fopt, xopt] = demo_opt(f, xrange)
plot(fopt(1,:), fopt(2,:), '0'), xlabel('obj1'),ylabel('obj2')
d = dtlz_distance(xopt, 'dtlz1');
min(d), mean(d),max(d)

