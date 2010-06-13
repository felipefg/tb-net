#!/usr/bin/env python

import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as p
import scipy.io.matlab

lineNames = {
        'useSP_0': 'Parada por MSE',
        'useSP_1': 'Parada por SP',
}

def getMatlabData(filename):
    """
    Read the 'results.mat' file, parse it, and return it in python format.
    """
    lines = []
    data = scipy.io.matlab.loadmat(filename)

    # We only care for the 'results' struct
    data = data['results'][0,0]

    for lineName in data._fieldnames:
        line = {}
        line['name'] = lineNames.get(lineName, lineName)
        line['batch'] = {}

        batch_set = data.__getattribute__(lineName)[0,0]

        for batchName in batch_set._fieldnames:
            batchSize = int(batchName.split('_')[1])
            batch = batch_set.__getattribute__(batchName)[0,0]

            line['batch'][batchSize] = {
                    'mse': batch.mses[0],
                    'sp': batch.SPs[0],
            }
        lines.append(line)
    return lines

def plotLines(lines):
    fig = p.figure()
    ax = fig.gca()
    for line in lines:
        X = sorted(line['batch'].keys())
        Y = []
        Yerr = []
        for x in X:
            Y.append(  np.mean(line['batch'][x]['sp']))
            Yerr.append(np.std(line['batch'][x]['sp']))

        ax.errorbar(X, Y, Yerr, label=line['name'], fmt='-o')

    ax.legend(loc='lower right')
    ax.grid()
    ax.set_xlabel('Tamanho da batelada')
    ax.set_ylabel('Produto SP maximo')
    ax.set_xticks(X)
    return fig

if __name__ == "__main__":
    lines = getMatlabData('results.mat')
    fig = plotLines(lines)
    p.savefig('sp_evolution.png')
