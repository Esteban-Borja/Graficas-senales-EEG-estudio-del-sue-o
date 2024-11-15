% Especifica el nombre del archivo
filename = 'Datos generales.xlsx';  % Cambia esto al nombre de tu archivo

% Cargar el archivo Excel
data_table = readtable(filename);

% Mostrar las primeras filas para verificar
disp('Datos cargados:');
disp(head(data_table));

% Extraer solo las columnas numéricas para el PCA (omitir columnas de texto como 'Sujeto' y 'Etapa')
numeric_data = data_table{1:end, 2:end};  % Asume que las variables numéricas empiezan en la columna 3

% Verificar el tamaño de la matriz numérica
disp('Dimensiones de los datos numéricos:');
disp(size(numeric_data));

% Realizar PCA
[coeff, score, latent, tsquared, explained] = pca(numeric_data);

% Mostrar la varianza explicada por cada componente
disp('Varianza explicada por cada componente principal (%):');
disp(explained);

% Graficar las primeras dos componentes principales
figure;
scatter(score(:,1), score(:,2), 'filled');
title('PCA - Primeras dos componentes principales');
xlabel('Componente 1');
ylabel('Componente 2');
grid on;

% Gráfico de varianza explicada
figure;
pareto(explained);
title('Varianza Explicada por Componentes Principales');
xlabel('Número de Componente');
ylabel('Porcentaje de Varianza Explicada');

% Calcular la varianza acumulada
varianza_acumulada = cumsum(explained);

% Encontrar el número mínimo de componentes necesarios para explicar al menos el 90% de la varianza
num_componentes = find(varianza_acumulada >= 90, 1);

disp(['Número de componentes que explican al menos el 90% de la varianza: ', num2str(num_componentes)]);

% Para el primer componente principal (PC1)
[~, idx] = sort(abs(coeff(:, 1)), 'descend');
disp('Variables más influyentes en PC1:');
disp(idx); % Esto te da los índices de las variables más influyentes

% Mostrar los nombres de las variables más influyentes si tienes una lista de nombres
variable_names = {'Delta-F3-1', 'Delta-F4-1', 'Delta-C3-1', 'Delta-C4-1', 'Delta-O1-1', 'Delta-O2-1', 'Theta-F3-1', 'Theta-F4-1', 'Theta-C3-1', 'Theta-C4-1', 'Theta-O1-1', 'Theta-O2-1', 'Alpha-F3-1', 'Alpha-F4-1', 'Alpha-C3-1', 'Alpha-C4-1', 'Alpha-O1-1', 'Alpha-O2-1', 'Delta-F3-2', 'Delta-F4-2', 'Delta-C3-2', 'Delta-C4-2', 'Delta-O1-2', 'Delta-O2-2', 'Theta-F3-2', 'Theta-F4-2', 'Theta-C3-2', 'Theta-C4-2', 'Theta-O1-2', 'Theta-O2-2', 'Alpha-F3-2', 'Alpha-F4-2', 'Alpha-C3-2', 'Alpha-C4-2', 'Alpha-O1-2', 'Alpha-O2-2', 'Delta-F3-3', 'Delta-F4-3', 'Delta-C3-3', 'Delta-C4-3', 'Delta-O1-3', 'Delta-O2-3', 'Theta-F3-3', 'Theta-F4-3', 'Theta-C3-3', 'Theta-C4-3', 'Theta-O1-3', 'Theta-O2-3', 'Alpha-F3-3', 'Alpha-F4-3', 'Alpha-C3-3', 'Alpha-C4-3', 'Alpha-O1-3', 'Alpha-O2-3', 'Delta-F3-4', 'Delta-F4-4', 'Delta-C3-4', 'Delta-C4-4', 'Delta-O1-4', 'Delta-O2-4', 'Theta-F3-4', 'Theta-F4-4', 'Theta-C3-4', 'Theta-C4-4', 'Theta-O1-4', 'Theta-O2-4', 'Alpha-F3-4', 'Alpha-F4-4', 'Alpha-C3-4', 'Alpha-C4-4', 'Alpha-O1-4', 'Alpha-O2-4', 'Delta-F3-5', 'Delta-F4-5', 'Delta-C3-5', 'Delta-C4-5', 'Delta-O1-5', 'Delta-O2-5', 'Theta-F3-5', 'Theta-F4-5', 'Theta-C3-5', 'Theta-C4-5', 'Theta-O1-5', 'Theta-O2-5', 'Alpha-F3-5', 'Alpha-F4-5', 'Alpha-C3-5', 'Alpha-C4-5', 'Alpha-O1-5', 'Alpha-O2-5'}; % Completa con tus nombres de variables
disp('Variables ordenadas por influencia en PC1:');
disp(variable_names(idx));

figure;
bar(coeff(:, 1)); % Mostrar cargas del primer componente
xticks(1:length(variable_names));
xticklabels(variable_names);
xtickangle(90);
title('Cargas en el Primer Componente Principal (PC1)');
ylabel('Peso de la variable');




