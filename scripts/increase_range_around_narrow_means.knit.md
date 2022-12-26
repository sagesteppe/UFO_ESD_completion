---
title: "Increase Variation Around Narrow ESD Concepts"
author: NULL
date: NULL
output:
  pdf_document: default
  word_document: default
header-includes:
 - \usepackage[width=\textwidth]{caption}
always_allow_html: yes
csl: ../citations/citations/apa.csl
bibliography: ../citations/citations/citations.bib
link-citations: yes
---

The quantitative benchmarks of ESDs are meant to capture the variation inherent in a state and phase under multiple conditions, from consecutive drought to surpluses of moisture, and following multiple disturbances (CITE). They are intended to capture the variation that would be found in this state and phase combination across the geographic and climatic extents of the ESD in the relevant MLRA. Some of the quantitative benchmarks, of the fractional cover of functional vegetation groups, for Ecological Sites which we collected from ESD's were very narrow. In many of these instances the reported values were more narrow than the uncertainty of the estimates of the true value of the population gleaned from a single AIM plot. It is apparent that several ESD developers did not emphasize the natural variability of the vegetation benchmarks while generating the cover estimates. This may be due to them only collecting quantitative vegetation data at a single site, and not across multiple time points, accordingly it seems in multiple instances they may only have had a point of datum, and did not feel comfortable estimate the variation in the system. 

Well that approach is prudent, it is not prudent for us to assume such narrow ranges of variation. These may unduly penalize estimates of the amount of land under analysis which are meeting condition benchmarks. Here we seek to identify and broaden these estimates, we will use a simple method of *imputing* values in the context of *feature engineering*. A *linear model* will be fit to the benchmark values, which contain realistic ranges, and then the slope of this model will be used to fill in the missing values.  











![](increase_range_around_narrow_means_files/figure-latex/Plot Initial variation-1.pdf)<!-- --> 


Ranges of estimated benchmark variation were estimated as being too low if they fell within the ranges in Table 1 & Figure 1 *top panel*. These XX values were removed from the initial data set. The remaining XX observations were used as **training** data for the linear models. Once the linear model was *fitted*, the removed data points had estimates of their values recorded. 

   Mean        Range
---------    ----------
  < 10          < 3
10 -  20        < 4
20 -  30        < 5
30 -  50        < 6


$\text{Range} \sim  \text{Mean + Functional Group}$






![](increase_range_around_narrow_means_files/figure-latex/unnamed-chunk-1-1.pdf)<!-- --> 





