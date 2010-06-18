%% ----------
load results_10v

figure
subplot(2,1,1)
plot_difference_global_n_epochs(trs, 100)
subplot(2,1,2)
plot_difference_n_epochs(trs, 100)

saveas(gcf, 'results_10v.fig', 'fig');
print(gcf, '-dpng', 'results_10v.png');

close

%% ----------

figure
subplot(2,1,1)
plot_difference_global_n_epochs(trs, 100, 1000)
subplot(2,1,2)
plot_difference_n_epochs(trs, 100, 1000)

saveas(gcf, 'results_10v_zoom.fig', 'fig');
print(gcf, '-dpng', 'results_10v_zoom.png');

close
%% ----------
load results_12v

figure
subplot(2,1,1)
plot_difference_global_n_epochs(trs, 100)
subplot(2,1,2)
plot_difference_n_epochs(trs, 100)

saveas(gcf, 'results_12v.fig', 'fig');
print(gcf, '-dpng', 'results_12v.png');

close
figure
subplot(2,1,1)
plot_difference_global_n_epochs(trs, 100, 1000)
subplot(2,1,2)
plot_difference_n_epochs(trs, 100, 1000)

saveas(gcf, 'results_12v_zoom.fig', 'fig');
print(gcf, '-dpng', 'results_12v_zoom.png');

close
%% ----------
load results_12v_alcione

figure
subplot(2,1,1)
plot_difference_global_n_epochs(trs, 100)
subplot(2,1,2)
plot_difference_n_epochs(trs, 100)

saveas(gcf, 'results_10v_alcione.fig', 'fig');
print(gcf, '-dpng', 'results_12v_alcione.png');

close
figure
subplot(2,1,1)
plot_difference_global_n_epochs(trs, 100, 1000)
subplot(2,1,2)
plot_difference_n_epochs(trs, 100, 1000)

saveas(gcf, 'results_10v_alcione_zoom.fig', 'fig');
print(gcf, '-dpng', 'results_12v_alcione_zoom.png');

close
