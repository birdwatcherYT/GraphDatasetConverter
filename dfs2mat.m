
function dfs2mat(filename)
	fid = fopen(filename);
	lgraph_data=[];

	I=0;
	while 1
		line=fgetl(fid);
		if length(line)==0||feof(fid)
			for e=Edge'
				GRAPH_DATA(I).am(e(1),e(2))=1;
				GRAPH_DATA(I).am(e(2),e(1))=1;
				GRAPH_DATA(I).am=sparse(GRAPH_DATA(I).am);
			end
			if length(Edge)~=0
				for i=1:length(GRAPH_DATA(I).am)
					L=[];
					for j=1:length(GRAPH_DATA(I).am)
						if GRAPH_DATA(I).am(i,j)
							L=[L,j];
						end
					end
					GRAPH_DATA(I).al{i,1}=L;
				end
			end
			for i=1:size(Vertex,1)
				GRAPH_DATA(I).nl.values(i)=Vertex(i,2);
			end
			GRAPH_DATA(I).nl.values=GRAPH_DATA(I).nl.values';
			if feof(fid)
				break;
			end
		end
		list=strsplit(line, ' ');
		if list{1}=='t'
			I=I+1;
			GRAPH_DATA(I).am=sparse(0,0);
			lgraph_data(I)=str2num(list{4});
			Vertex=[];
			Edge=[];
		end
		if list{1}=='v'
			Vertex=[Vertex; str2num(list{2}),str2num(list{3}) ];
		end
		if list{1}=='e'
			Edge=[Edge; str2num(list{2}),str2num(list{3}),str2num(list{4}) ];
		end
	end
	fclose(fid);
	save(strcat(filename,'.mat'), 'GRAPH_DATA', 'lgraph_data')
end

