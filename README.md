# ODML
[Distance metric learning for ordinal classification based on triplet constraints](https://doi.org/10.1016/j.knosys.2017.11.022)

For any question, please contact [Bac Nguyen](mailto:Bac.NguyenCong@ugent.be).

## Abstract
Ordinal classification is a problem setting in-between nominal classification and metric regression, where the goal is to predict classes of an ordinal scale. Usually, there is a clear ordering of the classes, but the absolute distances between them are unknown. Disregarding the ordering information, this kind of problems is commonly treated as multi-class classification problems, however, it often results in a significant loss of performance. Exploring such ordering information can help to improve the effectiveness of classifiers. In this paper, we propose a distance metric learning approach for ordinal classification by incorporating local triplet constraints containing the ordering information into a conventional large-margin distance metric learning approach. Specifically, our approach tries to preserve, for each training example, the ordinal relationship as well as the local geometry structure of its neighbors, which is suitable for use in local distance-based algorithms such as k-nearest-neighbor (k-NN) classification. Different from previous works that usually learn distance metrics by weighing the distances between training examples according to their class label differences, the proposed approach can directly satisfy the ordinal relationships where no assumptions about the distances between classes are made.

**How to learn a linear transformation A ?**

<img src="figs/formulation.png" style="max-width:100%; width: 30%" > <img src="figs/illustration.jpg" style="max-width:100%; width: 30%">

### Prerequisites
This has been tested using MATLAB 2010A and later on Windows and Linux (Mac should be fine).

## Installation
Download the folder "ODML" into the directory of your choice. Then within MATLAB go to file >> Set path... and add the directory containing "ODML" to the list (if it isn't already). That's it.

## Usage
```matlab
>> demo
```
## Authors

* [Bac Nguyen Cong](https://github.com/bacnguyencong)

## Acknowledgments
If you find this code useful in your research, please consider citing:
``` bibtex
@Article{Nguyen2018a,
  Title       = {Distance metric learning for ordinal classification based on triplet constraints},
  Author      = {Bac Nguyen and Carlos Morell and De Baets, Bernard},
  Journal     = {Knowledge-Based Systems},
  Year        = {2018},
  Pages       = {17-28},
  Volume      = {142}
}
```

