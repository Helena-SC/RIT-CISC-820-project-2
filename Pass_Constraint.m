function result = Pass_Constraint (x)

    m = 500;
    n = 100;
    
    fid = fopen('fun2_A.txt','r');
  	A = fscanf(fid,'%e ',[m,n]);
  	fclose(fid);

	
	fid = fopen('fun2_b.txt','r');
	b = fscanf(fid, '%e', [m,1]);
	fclose(fid);
    
    mask = b > A*x;
    if (all(mask))
        result = true;
    else
        result =  false;
    end

end