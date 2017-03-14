close all;
clear all;

load('assign2 2017.mat');
%% case 1
wrong_1nn = 0;
wrong_3nn = 0;
wrong_5nn = 0;
wrong_med = 0;
wrong_ged = 0;


%% iterate 200 times with 199 training data
for i = 1:200
    train_a = a3;
    train_a(:,i) = [];
    test_a = a3(:,i);
    mu_a = mean(train_a,2);
    sigma_a = cov(train_a');
    
    train_b = b3;
    train_b(:,i) = [];
    test_b = b3(:,i);
    mu_b = mean(train_b,2);
    sigma_b = cov(train_b');
    
    %% 1nn
    train_knn = [train_a,train_b]';
    group_knn = [ones(199,1);zeros(199,1)];
    Mdl1 = fitcknn(train_knn,group_knn,'NumNeighbors',1);
    classes_a = predict(Mdl1,test_a');
    classes_b = predict(Mdl1,test_b');
    wrong_1nn = wrong_1nn + 1 - sum(classes_a) + sum(classes_b);
    

    %% 3nn
    Mdl3 = fitcknn(train_knn,group_knn,'NumNeighbors',3);
    classes_a = predict(Mdl3,test_a');
    classes_b = predict(Mdl3,test_b');
    wrong_3nn = wrong_3nn + 1 - sum(classes_a) + sum(classes_b);
    
    %% 5nn
    Mdl5 = fitcknn(train_knn,group_knn,'NumNeighbors',5);
    classes_a = predict(Mdl5,test_a');
    classes_b = predict(Mdl5,test_b');
    wrong_5nn = wrong_5nn + 1 - sum(classes_a) + sum(classes_b);
    
    %% MED, GED 
    
    if ((test_a - mu_a)' * (test_a - mu_a)) > ((test_a - mu_b)' * (test_a - mu_b))
        wrong_med = wrong_med + 1;
    end
    
    if ((test_b - mu_a)' * (test_b - mu_a)) < ((test_b - mu_b)' * (test_b - mu_b))
        wrong_med = wrong_med + 1;
    end

    if (test_a - mu_a)' * sigma_a^-1 * (test_a - mu_a) > (test_a - mu_b)' * sigma_b^-1 * (test_a - mu_b)
        wrong_ged = wrong_ged + 1;
    end

    if (test_b - mu_a)' * sigma_a^-1 * (test_b - mu_a) < (test_b - mu_b)' * sigma_b^-1 * (test_b - mu_b)
        wrong_ged = wrong_ged + 1;        
    end
    
    
    
end
error_3_med = wrong_med/400
error_3_ged = wrong_ged/400
error_3_1nn = wrong_1nn/400
error_3_3nn = wrong_3nn/400
error_3_5nn = wrong_5nn/400

