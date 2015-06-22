# sfc.parameters
Function for testing different sets of model parameters

This function extends PKSFC library.
PKSFC library allows creating Stock-flow consistent macroeconomic models. For details check http://antoinegodin.eu/pksfc

sfc.parameters function takes as parameters two txt files, first one with model and second one with parameters.
Second file has following structure:
Name_of_the_parameter starting value ending value step

for example:
alpha 0.1 0.5 0.1
beta 0.0 0.1 0.01

The function creates data frame with all possible combinations of the full set of parameters. In our case that will be:
alpha 0.1 0.2 0.3 0.4 0.5
beta 0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1

Then it simulates model with all combinations in a loop.
In the last step the function returns summary of the models' behaviour.

To do:
1. Finish parallel processing
2. Create nice summary

