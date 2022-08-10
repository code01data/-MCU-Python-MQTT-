a = [1:1:8]
b = []
for i = 1:size(a,2)
    A = [1,2,a(i);1/2,1,2;1/a(i),1/2,1]
    b = [b,max(eig(A))]
end
plot(a,b)

