function error = calculate_RRMSE(noiseless,noisy)

error = sqrt(sum(sum((abs(noiseless) - abs(noisy)).^2)))/sqrt(sum(sum(noiseless.^2)));