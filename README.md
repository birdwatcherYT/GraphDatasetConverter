# GraphDatasetConverter
グラフデータセットをmatlab形式や, DFSコードの形式へ変換する

## txt2dfs.m
https://ls11-www.cs.tu-dortmund.de/staff/morris/graphkerneldatasets からダウンロードできるtxt形式をDFSコード形式へ変換する. 

グラフが連結でない場合は, 最も大きいグラフが選ばれる.

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
