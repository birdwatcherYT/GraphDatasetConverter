# GraphDatasetConverter
グラフデータセットをmatlab形式や, DFSコードの形式へ変換する

matlab形式は, 有名な[グラフカーネルの実装](http://mlcb.is.tuebingen.mpg.de/Mitarbeiter/Nino/Graphkernels/)で使うためのものである. 

DFS形式は, [Pattern Mining](https://github.com/birdwatcherYT/PatternMining)で使うための形式である. 

## txt2dfs.m
https://ls11-www.cs.tu-dortmund.de/staff/morris/graphkerneldatasets からダウンロードできるtxt形式をDFSコード形式へ変換する. 

グラフが連結でない場合は, 最も大きい連結グラフが選ばれる.

Example: `txt2dfs('Mutagenicity')`
- `Mutagenicity`というファイルができる. 

## txt2mat.m
https://ls11-www.cs.tu-dortmund.de/staff/morris/graphkerneldatasets からダウンロードできるtxt形式をmat形式へ変換する. 

Example: `txt2mat('Mutagenicity')`
- `Mutagenicity.mat`というファイルができる. 

## dfs2mat.m
DFSコード形式からmat形式へ変換する. 

Example: `txt2mat('Mutagenicity')`
- `Mutagenicity.mat`というファイルができる. 
