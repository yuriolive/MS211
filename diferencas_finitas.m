function [x w] = diferencas_finitas
    a = 1;
    b = 2;
    w_start = 0;
    w_final = 2;
    h = 0.05;
    n = -1 + (b - a)/h;

    a_v = [1:n];
    b_v = [1:n];
    c_v = [1:n];
    d_v = [1:n];

    l = [1:n];
    u = [1:n];
    z = [1:n];
    t = [1:n];

    for i = 1:n
        w(i) = w_start + i * h * (w_final - w_start)/(b - a);
    end


    % Calculo dos valores da primeira linha da matriz
    k = a + h;
    t = (w(2) - w_start)/(2*h);
    a_v(1) = 2 + h*h*fy(k, w(1), t);
    b_v(1) = -1 + h*fy_linha(k, w(1), t)/2;
    d_v(1) = -(2*w(1) - w(2) - w_start + h*h*f(k, w(1), t));
    
    % Calculo dos valores dos valores das linhas 2 ate n-1 da matriz
    for i = 2:(n-1)
        k = a + i*h;
        t = (w(i+1) - w(i-1))/(2*h);
        a_v(i) = 2 + h*h*fy(k, w(i), t);
        b_v(i) = -1 + h*fy_linha(k, w(i), t)/2;
        c_v(i) = -1 - h*fy_linha(k, w(i), t)/2;
        d_v(i) = -(2*w(i) - w(i) - w(i-1) + h*h*f(k, w(i), t));
    end

    % Calculo dos valores da linha n da matriz
    k = b - h;
    t = (w_final - w(n-1))/(2*h);
    a_v(n) = 2 + h*h*fy(k, w(n), t);
    c_v(n) = -1 - h*fy_linha(k, w(n), t)/2;
    d_v(n) = -(2*w(n) - w(n-1) - w_final + h*h*f(k, w(n), t));

    % Resolvendo a matriz
    l(1) = a_v(1);
    u(1) = b_v(1)/a_v(1);

    for i = 2:(n-1)
        l(i) = a_v(i) - c_v(i)*u(i-1);
        u(i) = b_v(i)/l(i);
    end

    l(n) = a_v(n) - c_v(n)*u(n-1);

    z(1) = d_v(1)/l(1);

    for i = 2:n
        z(i) = d_v(i) - c_v(i)*z(i-1)/l(i);
    end

    t(n) = z(n);
    w(n) = w(n) + t(n);

    for i from (n-1) to 1 do
        t(i) = z(i) - u(i)*t(i+1);
        w(i) = w(i) + t(i);
    end

    for i = 1:n
        x(i) = a + i*h;
    end

end

