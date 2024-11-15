% % Cargar la tabla de datos
% filename = 'Datos generales.xlsx';
% data_table = readtable(filename);
% 
% % Convertir la tabla a una matriz (asegurarse de que no hay columnas no numéricas)
% X = table2array(data_table(:, 2:end)); % omite la primera columna si es de nombres
% % Elegir el número de clusters (por ejemplo, 2 para insomnio vs. normal)
% num_clusters = 2;
% 
% % Aplicar K-means
% [idx, centroids] = kmeans(X, num_clusters);
% 
% % idx contiene las etiquetas asignadas a cada fila (sujeto) en X
% % Reducir la dimensionalidad a 2D usando PCA
% [coeff, score, ~, ~, explained] = pca(X);
% 
% % Visualizar los clusters
% figure;
% gscatter(score(:, 1), score(:, 2), idx);
% xlabel('Componente Principal 1');
% ylabel('Componente Principal 2');
% title('Análisis de Clustering con K-means');
% legend('Cluster 1', 'Cluster 2');
% % Calcular el índice de silueta
% silhouette(X, idx);
% title('Gráfico de Silueta para K-means Clustering');
% 
% % labels = [etiquetas originales: 1 = insomnio, 0 = sueño normal]
% diagnostico=data_table.Diagnostico;
% [~, table] = crosstab(diagnostico, idx);
% 
% % table te muestra cómo se distribuyen las etiquetas en cada cluster
% disp(table);
% % Realizar PCA y obtener las primeras tres componentes
% [coeff, score, ~, ~, explained] = pca(X);
% 
% % Graficar los sujetos según sus primeras tres componentes principales
% figure;
% scatter3(score(idx == 1, 1), score(idx == 1, 2), score(idx == 1, 3), 'r', 'filled');
% hold on;
% scatter3(score(idx == 2, 1), score(idx == 2, 2), score(idx == 2, 3), 'b', 'filled');
% legend('Cluster 1', 'Cluster 2');
% xlabel('PC1'); ylabel('PC2'); zlabel('PC3');
% title('Visualización de Clusters en el Espacio de PCA');
% grid on;
% 
% % Aplicar el algoritmo K-means con 2 clusters (uno para insomnio y otro para sueño normal)
% [idx, ~] = kmeans(X, 2);
% 
% % Evaluar el resultado del clustering
% [~, table] = crosstab(diagnostico, idx);
% 
% % Mostrar la tabla de contingencia
% disp('Tabla de contingencia entre diagnóstico real y clusters:');
% disp(table);

% Cargar datos desde el archivo Excel
filename = 'Datos generales_2.xlsx';
data_table = readtable(filename);

% Asegúrate de que la columna de diagnóstico esté correctamente extraída
diagnostico = data_table.Var91; % Ajusta el nombre si es necesario

% Convertir la columna de diagnóstico a tipo categorical si es necesario
if ~iscategorical(diagnostico)
    diagnostico = categorical(diagnostico);
end

% Extraer solo las columnas numéricas (características EEG)
% Asumimos que la primera columna es el diagnóstico y las siguientes son datos numéricos
data = data_table(:, 1:end); % Asegúrate de ajustar el índice según tu tabla

% Asegúrate de que 'data' sea una tabla antes de convertirla
if istable(data)
    data = table2array(data); % Convierte tabla a matriz numérica
end

% Aplicar el algoritmo K-means con 2 clusters (para insomnio y sueño normal)
[idx, ~] = kmeans(data, 2);

% Asegurarse de que 'idx' y 'diagnostico' tengan el mismo tamaño
if length(diagnostico) ~= length(idx)
    error('El tamaño de diagnostico y idx no coincide');
end

% Evaluar el resultado del clustering
[~, table] = crosstab(diagnostico, idx);

% Mostrar la tabla de contingencia
disp('Tabla de contingencia entre diagnóstico real y clusters:');
disp(table);

