import matplotlib.pyplot as plt
import pandas as pd

logs = pd.read_table('./logs/log_file', delimiter='\t')
logs['Valid. Perplexity'] = logs['Valid. Perplexity'].str.extract('(\d+)').astype(int)
logs.set_index('Valid. Perplexity', inplace=True)

# Plot the first chart: Perplexity over Epochs for each Dropout
plt.figure(figsize=(12.5, 7.5))
for column in logs.columns:
    plt.plot(logs.index, logs[column], label=column)
plt.title('Perplexity over Epochs for Different Dropout Settings')
plt.xlabel('Epoch')
plt.ylabel('Perplexity')
plt.legend(title='Dropout Settings')
plt.grid(True)
plt.savefig('logs/perplexity_over_epochs.png')
plt.show()

# Plot the second chart: Perplexity for each Dropout setting across Epochs
plt.figure(figsize=(12.5, 7.5))
for index, row in logs.iterrows():
    plt.plot(logs.columns, row, label=f'Epoch {index}')
plt.title('Perplexity for Different Dropout Settings Across Epochs')
plt.xlabel('Dropout Settings')
plt.ylabel('Perplexity')
plt.grid(True)
plt.savefig('logs/perplexity_across_dropouts.png')
plt.show()

