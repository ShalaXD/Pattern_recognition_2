close all;
clear all;

load('assign2 2017.mat');
%% case 1
error_med = [];
error_ged = [];
error_1nn = [];
error_3nn = [];
error_5nn = [];

%% iterate 40 times with 5 training data
for i = 1:40
    wrong_med = 0;
    wrong_ged = 0;
    
    train_a = a1(:,5*i-4:5*i);
    test_a = a1;
    test_a(:,5*i-4:5*i) = [];
    mu_a = mean(train_a,2);
    sigma_a = cov(train_a');
    
    train_b = b1(:,5*i-4:5*i);
    test_b = b1;
    test_b(:,5*i-4:5*i) = [];
    mu_b = mean(train_b,2);
    sigma_b = cov(train_b');
    
    %% 1nn
    train_knn = [train_a,train_b]';
    group_knn = [1;1;1;1;1;0;0;0;0;0];
    Mdl1 = fitcknn(train_knn,group_knn,'NumNeighbors',1);
    classes_a = predict(Mdl1,test_a');
    classes_b = predict(Mdl1,test_b');
    
    wrong_a = 195 - sum(classes_a);
    wrong_b = sum(classes_b);
    wrong_1nn = (wrong_a + wrong_b)/(195*2);
    error_1nn = [error_1nn, wrong_1nn];

    %% 3nn
    Mdl3 = fitcknn(train_knn,group_knn,'NumNeighbors',3);
    classes_a = predict(Mdl3,test_a');
    classes_b = predict(Mdl3,test_b');
    
    wrong_a = 195 - sum(classes_a);
    wrong_b = sum(classes_b);
    wrong_3nn = (wrong_a + wrong_b)/(195*2);
    error_3nn = [error_3nn, wrong_3nn];
    
    %% 5nn
    Mdl5 = fitcknn(train_knn,group_knn,'NumNeighbors',5);
    classes_a = predict(Mdl5,test_a');
    classes_b = predict(Mdl5,test_b');
    
    wrong_a = 195 - sum(classes_a);
    wrong_b = sum(classes_b);
    wrong_5nn = (wrong_a + wrong_b)/(195*2);
    error_5nn = [error_5nn, wrong_5nn];
   
    %% MED, GED 
    for j = 1:195
        
        if ((test_a(:,j) - mu_a)' * (test_a(:,j) - mu_a)) > ((test_a(:,j) - mu_b)' * (test_a(:,j) - mu_b))
            wrong_med = wrong_med + 1;
        end
    
        if ((test_b(:,j) - mu_a)' * (test_b(:,j) - mu_a)) < ((test_b(:,j) - mu_b)' * (test_b(:,j) - mu_b))
            wrong_med = wrong_med + 1;
        end
    
        
        if (test_a(:,j) - mu_a)' * sigma_a^-1 * (test_a(:,j) - mu_a) > (test_a(:,j) - mu_b)' * sigma_b^-1 * (test_a(:,j) - mu_b)
            wrong_ged = wrong_ged + 1;
        end
        
        if (test_b(:,j) - mu_a)' * sigma_a^-1 * (test_b(:,j) - mu_a) < (test_b(:,j) - mu_b)' * sigma_b^-1 * (test_b(:,j) - mu_b)
            wrong_ged = wrong_ged + 1;
        end
        
    end
    error_med = [error_med,(wrong_med/(195*2))];
    error_ged = [error_ged,(wrong_ged/(195*2))];
    
end

%% calculate errors
error_1_med = mean(error_med)
std_1_med = std(error_med)

error_1_ged = mean(error_ged)
std_1_ged = std(error_ged)

error_1_1nn = mean(error_1nn)
std_1_1nn = std(error_1nn)

error_1_3nn = mean(error_3nn)
std_1_3nn = std(error_3nn)

error_1_5nn = mean(error_5nn)
std_1_5nn = std(error_5nn)