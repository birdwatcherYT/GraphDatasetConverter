% https://ls11-www.cs.tu-dortmund.de/staff/morris/graphkerneldatasets
% to mat

function txt2mat(filename)
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
	for graph_id=unique(Temp.filename_graph_indicator)'
		% for each graph
		indicator=find(Temp.filename_graph_indicator==graph_id);
		beginValue=indicator(1);
		endValue=indicator(end);
		connect=Temp.filename_A((beginValue<=Temp.filename_A(:,1) ) & (Temp.filename_A(:,1) <=endValue),:)-beginValue+1;
		edgelabel=Temp.filename_edge_labels((beginValue<=Temp.filename_A(:,1) ) & (Temp.filename_A(:,1) <=endValue));
		label=Temp.filename_node_labels(beginValue:endValue);
		link=cell(1,endValue-beginValue+1);
		
		GRAPH_DATA(graph_id).am=sparse(0,0);
		for c=connect'
			GRAPH_DATA(graph_id).am(c(1),c(2))=1;
			GRAPH_DATA(graph_id).am(c(2),c(1))=1;
		end
		GRAPH_DATA(graph_id).am=sparse(GRAPH_DATA(graph_id).am);
		
		if size(connect,1)~=0
			EL=[];
			for i=1:length(GRAPH_DATA(graph_id).am)
				L=[];
				for j=1:length(GRAPH_DATA(graph_id).am)
					if GRAPH_DATA(graph_id).am(i,j)
						L=[L,j];
						EL=[EL; i,j,edgelabel((connect(:,1)==i) & (connect(:,2)==j))];
					end
				end
				GRAPH_DATA(graph_id).al{i,1}=L;
			end
			GRAPH_DATA(graph_id).el.values=EL;
		end
		GRAPH_DATA(graph_id).nl.values=label;
	end
	lgraph_data=Temp.filename_graph_labels;
	save(strcat(filename,'.mat'), 'GRAPH_DATA', 'lgraph_data')
end
