% https://ls11-www.cs.tu-dortmund.de/staff/morris/graphkerneldatasets
% to dfscode

function txt2dfs(filename)
	set(0,'RecursionLimit',10000); % matlab
	% max_recursion_depth (10000); % octave
	Temp.filename_A = importdata(strcat(filename, '_A.txt'), ','); 
	if fopen(strcat(filename, '_edge_labels.txt'))<0
		Temp.filename_edge_labels=ones(size(Temp.filename_A,1),1);
	else 
		Temp.filename_edge_labels = importdata(strcat(filename, '_edge_labels.txt'), ','); 
	end
	Temp.filename_graph_indicator = importdata(strcat(filename,'_graph_indicator.txt'), ','); 
	Temp.filename_graph_labels = importdata(strcat(filename, '_graph_labels.txt'), ','); 
	if fopen(strcat(filename, '_node_labels.txt'))<0
		Temp.filename_node_labels = ones(size(Temp.filename_graph_indicator,1),1);
	else 
		Temp.filename_node_labels = importdata(strcat(filename, '_node_labels.txt'), ','); 
	end
	fileID = fopen(filename,'w');
	for graph_id=unique(Temp.filename_graph_indicator)'
		% for each graph
		indicator=find(Temp.filename_graph_indicator==graph_id);
		beginValue=indicator(1);
		endValue=indicator(end);
		connect=Temp.filename_A((beginValue<=Temp.filename_A(:,1) ) & (Temp.filename_A(:,1) <=endValue),:)-beginValue+1;
		edgelabel=Temp.filename_edge_labels((beginValue<=Temp.filename_A(:,1) ) & (Temp.filename_A(:,1) <=endValue));
		label=Temp.filename_node_labels(beginValue:endValue);
		link=cell(1,endValue-beginValue+1);
		for c=connect'
			link{c(1)}=unique([link{c(1)}, c(2)]);
			link{c(2)}=unique([link{c(2)}, c(1)]);
		end
		visited=[];edges=[];map=[];
		nodes=1:length(label);
		MAX=-1;
		while length(nodes)~=0 %最大連結グラフを取ってくる
			[Visited,Edges,Map]=dfs(nodes(1), [], [], [], link);
			if MAX<length(Visited)
				MAX=length(Visited);visited=Visited;edges=Edges;map=Map;
			end
			nodes=setdiff(nodes,Visited);
		end
		%visited,edges,map
		fprintf(fileID, 't # 0 %d\n', Temp.filename_graph_labels(graph_id));
		for v=visited'
			fprintf(fileID, 'v %d %d\n', map(v), label(v));
		end
		for e=edges'
			fprintf(fileID, 'e %d %d %d\n', map(e(1)), map(e(2)), edgelabel((connect(:,1)==e(1)) & (connect(:,2)==e(2))));
		end
		fprintf(fileID, '\n');
	end
	fclose(fileID);
end

function [visited,edges,map]=dfs(vertex, visited, edges, map, link)
	map(vertex) = length(visited)+1;
	visited=[visited; vertex];
	temp = [];
	for v=link{vertex}%既にvに訪問したが, 辺(v,vertex)には訪問してないv
		if ismember(v,visited) && (isempty(edges) || (sum((v==edges(:,2)).*(vertex==edges(:,1)))==0 && sum((v==edges(:,1)).*(vertex==edges(:,2)))==0))
			temp=[temp;[map(v), v]];
		end
	end
	if length(temp)~=0
		[~,argsort]=sort(temp(:,1));%インデックス順ソート
		for idx=argsort'%訪問辺に追加
			edges=[edges;[vertex, temp(idx, 2)]];
		end
	end
	for v=link{vertex}
		if ~ismember(v,visited)
			edges=[edges;[vertex, v]];
			[visited,edges,map]=dfs(v, visited, edges, map, link);
		end
	end
end
