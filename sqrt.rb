require "mathn"
n, *a = IO.read("input.txt").split.map(&:to_f)
a = [(0...(n + 1) * n).to_a, a].transpose
m = Array.new(n + 1){[]}
a.each do |i|
	m[i[0] % (n + 1)].push(i[1])
end
b = m.pop
m = m.transpose
s = Array.new(n){Array.new(n){0}}
for i in (0...n)
	for j in (i...n)
		if i == 0
			if j == 0
				s[i][j] = Math.sqrt(m[i][j])
			else
				s[i][j] = m[i][j] / s[i][i]
			end
			next
		end
		if i == j
			s[i][j] = Math.sqrt((0...i).to_a.map{|k| s[k][i] ** 2 }.inject(m[i][j]){|r, x| r - x})
		end
		if i < j
			s[i][j] = (0...i).to_a.map{|k| s[k][i] * s[k][j]}.inject(m[i][j]){|r, x| r - x} / s[i][i]
		end
	end
end
s = s.transpose
y = Array.new(n){0}
x = Array.new(n){0}
y[0] = b[0] / s[0][0]
(1...n).each do |i|
	y[i] = (0...i).to_a.map{|k| s[i][k] * y[k]}.inject(b[i]){|r, x| r - x} / s[i][i]
end
s = s.transpose
x[n - 1] = y[n - 1] / s[n - 1][n - 1]
(0...n - 1).to_a.reverse.each do |i|
	x[i] = (i + 1...n).to_a.map{|k| s[i][k] * x[k]}.inject(y[i]){|r, x| r - x} / s[i][i]
end
p x
