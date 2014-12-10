function plot_diferenca()

	w = diferencas_finitas();

    for i = 1:19
    	k(i) = 1 + i*0.05;
    end

    k(i+1) = 1;
    w(i+1) = 0;

    k(i+2) = 2;
    w(i+2) = log(256);

	scatter(k, w, 'filled');

    hold on;

    s_x = linspace(1, 2, 100);
	s_y = s_x.*s_x.*s_x.*log(s_x);

    plot(s_x, s_y, 'color', 'r');

end