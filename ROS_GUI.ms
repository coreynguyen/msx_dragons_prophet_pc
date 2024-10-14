clearlistener()


try(DestroyDialog ROS_IMPORTER)catch(ROS_IMPORTER)
rollout ROS_IMPORTER "ROS Importer" (
	local g,f,BNArr=#(),mscale=1.0,maton=false,fsize,folderpath="",searchskl=false
	group "Import" (
		button btn2 "Mesh" width:120 height:30 align:#center
		button btn3 "Static Mesh" width:120 height:30 align:#center
		button btn1 "Skeleton" width:120 height:30 align:#center
		checkbox chk1 "Material" checked:maton align:#left
		checkbox chk2 "AutoLoad Skeleton" checked:maton align:#left
		checkbox chk3 "Clear Scene" checked:true align:#left
		)
	group "Options" (
		spinner spn1 "Scale" range:[1,100,0] type:#float align:#left
		edittext edt1 "Texture Path"  align:#center
		)
	group "About" (
-- 		label lbl1 "Orignal Written by: Zaramot"
		label lbl2 "By: mariokart64n"
		)
	struct _skeleton (
		name=#(),
		position=#(),
		parent=#(),
		node=#()
		)
	struct _materials (
		name=#(),
		DiffuseMap=#(),
		NormalMap=#(),
		GlossMap=#()
		)
	struct _model (
		position=#(),
		colour=#(),
		normal=#(),
		tangent=#(),
		texture=#(),
		weight=#(),
		boneid=#(),
		face=#(),
		matid=#(),
		mat=_materials(),
		skeleton=_skeleton()
		)
	struct weight_data (
	   boneids,weights
		)
	struct Bone_Info_Struct (
		Bone1,Bone2,Bone3,Bone4
		)
	struct Weight_Info_Struct	(
		Weight1,Weight2,Weight3,Weight4
		)
	fn buildSkin msh boneids weights = (
		local skinMod
		local i, j, bi, wv, boneid, weight, maxbone  -- Declare variables as local

		if BNArr.count != 0 and boneids.count != 0 do (
			try (
				max modify mode
				select msh
				skinMod = skin()
				addModifier msh skinMod

				-- Loop through all bones in BNArr and add them to the skin modifier
				for i = 1 to BNArr.count do (
					maxbone = BNArr[i]
					if i != BNArr.count then
						skinOps.addBone skinMod maxbone 0
					else
						skinOps.addBone skinMod maxbone 1
					)

				-- Set the skin modifier as the current object
				modPanel.setCurrentObject skinMod

				-- Loop through boneids and weights to replace vertex weights
				for i = 1 to boneids.count do (
					bi = #()  -- Bone index array
					wv = #()  -- Weight value array

					for j = 1 to boneids[i].count do (
						boneid = boneids[i][j]
						weight = weights[i][j]
						append bi boneid
						append wv weight
						)
					-- Apply the weights to the skin modifier
					skinOps.ReplaceVertexWeights skinMod i bi wv
					)
				) catch()
			)
		)
	fn buildObj clear_scene:true = (
		local j, msh, mat, tex  -- Declare variables as local

		-- If clear_scene is true, delete all objects
		if clear_scene do (delete objects)

		-- Create a mesh from the global variable 'g' (assuming 'g' is defined elsewhere)
		msh = mesh vertices:g.position faces:g.face --materialIDs:g.matid
		msh.numTVerts = g.texture.count
		buildTVFaces msh

		-- Set texture vertices and faces
		for j = 1 to g.texture.count do setTVert msh j g.texture[j]
		for j = 1 to g.face.count do setTVFace msh j g.face[j]

		-- Mesh display settings
		msh.displayByLayer = false
		msh.backfacecull = on
		msh.wirecolor = random (color 0 0 0) (color 255 255 255)

		-- If material assignment is enabled
		if maton == true do (
			mat = standardmaterial()
			mat.name = g.mat.name[1]

			-- Set diffuse map
			tex = folderpath + (filenameFromPath (g.mat.DiffuseMap[1] + ".dds"))
			mat.diffuseMap = Bitmaptexture fileName:tex
			mat.diffuseMap.alphaSource = 2

			-- Set normal map
			tex = folderpath + (filenameFromPath (g.mat.NormalMap[1] + ".dds"))
			mat.specularLevel = 20
			mat.bumpMap = Normal_Bump ()
			mat.bumpMap.normal_map = Bitmaptexture fileName:tex
			mat.bumpMap.normal_map.alphaSource = 2

			-- Set gloss map
			tex = folderpath + (filenameFromPath (g.mat.GlossMap[1] + ".dds"))
			mat.glossinessMap = Bitmaptexture fileName:tex
			mat.glossinessMap.alphaSource = 2

			-- Assign material to the mesh
			msh.material = mat
			showTextureMap mat true
			)

		-- Build the skin for the mesh using bone IDs and weights
		buildSkin msh g.boneid g.weight

		-- Zoom to the extents of the scene
		max tool zoomextents
		)
	fn RH2LH corrd = (
		[corrd.x,corrd.z,corrd.y]
		)
	fn enumblockformat num = (
		case num of (
			0x02: 0x10 -- 4 float32's
			0x06: 0x0C -- 3 float32's
			0x10: 0x08 -- 2 float32's
			0x1C: 0x04 -- 4byte rgba colour
			0x1E: 0x04 -- 4bytes unsigned?
			0x2A: 0x04
			default: (
				format "Block Size Unknown [%]\n" num
				0x00
				)
			)
		)
	fn enumHashCode hash = (
		case hash of (
			"F451AFD336445840A3B56D8366CC24A5B38259908A4948FF0A4D3393394AB23C": #ModelData
			"3CA647FF1D4F22FD4D5B56A723C20C0BF451AFD336445840A3B56D8366CC24A5": #SkeletonData
			"9ADF68B8B142F4377FE072A3B0836E0AB38259908A4948FF0A4D3393394AB23C": #AnimationData
			"9C092A3BAC491EAF665C3B893BCE0172B38259908A4948FF0A4D3393394AB23C": #VertexData
			"0B8F5AB1DA46E0166EFAC0B7215DBF2BB38259908A4948FF0A4D3393394AB23C": #FaceData
			"D35FA6FF6C46131562393D81D5EBEA5EB38259908A4948FF0A4D3393394AB23C": #MaterialData
			default: (
	-- 			format "New HashCode\n\t%\n\n" hash
				#Unknown
				)
			)
		)
	fn ReadFixedString bstream fixedLen = (
		local str = ""
		for i = 1 to fixedLen do (
			str += bit.intAsChar (ReadByte bstream #unsigned)
			)
		str
		)
	fn paddstring len instring = (
		instring=instring as string
		local str=""
		if instring.count <=len then (
			for i = 1 to (len-instring.count) do(
				str+="0"
				)
			str = (str+instring)
			)
		else (
			for i = 1 to len do(
				str+="0";str[i]=instring[i]
				)
			)
		str
		)
	fn uppercase instring = (
		local upper, lower, outstring
		upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		lower="abcdefghijklmnopqrstuvwxyz"
		outstring=copy instring
		for i=1 to outstring.count do (
			j=findString lower outstring[i]
			if (j != undefined) do outstring[i]=upper[j]
			)
		outstring
		)
	fn readhashasstring bstream len = (
		local i,str=""
		for i = 1 to len do (
			str += paddstring 2 (bit.intAsHex (readbyte bstream #unsigned))
			)
		return ( uppercase(str) )
		)
	fn readdatablock count vertex_count = (
		local i, p, blockstring, blocksize, x  -- Declare necessary variables as local

		-- Store the file position using ftell
		p = ftell f

		-- Initialize loop counter
		i = 0
		
		-- Start the loop for reading the blocks
		while i < count do (
			i += 1

			-- Read the block string and block size
			blockstring = ReadFixedString f (readlong f #unsigned)
			readlong f #unsigned
			
			-- Handle different block types using the block string
			case blockstring of (
				"position": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						append g.position (RH2LH ([(readfloat f), (readfloat f), (readfloat f)] * mscale))
						)
					)
				"normal": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						readfloat f
						readfloat f
						readfloat f
						)
					)
				"tangent": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						readfloat f
						readfloat f
						readfloat f
						readfloat f
						)
					)
				"color": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						readbyte f #unsigned -- RGBA
						readbyte f #unsigned
						readbyte f #unsigned
						readbyte f #unsigned
						)
					)
				"uv": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						append g.texture [(readfloat f), (-readfloat f), 0]
						)
					)
				"blend indices": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						append g.boneid [(readbyte f #unsigned + 1), (readbyte f #unsigned + 1), (readbyte f #unsigned + 1), (readbyte f #unsigned + 1)]
						)
					)
				"blend weights": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						readfloat f
						readfloat f
						readfloat f
						readfloat f
						)
					)
				"quaternion": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						append g.weight [(readfloat f), (readfloat f), (readfloat f), (readfloat f)]
						)
					)
				"flag": (
					blocksize = (enumblockformat(readlong f #unsigned)) * vertex_count
					for x = 1 to vertex_count do (
						readbyte f #unsigned
						readbyte f #unsigned
						readbyte f #unsigned
						readbyte f #unsigned
						)
					)
				"skinned": (
					readlong f #unsigned
					)
				"material type": (
					print (ReadFixedString f (readlong f #unsigned))
					)
				"material id": (
					readlong f #unsigned
					)
				"spec str multiplier": (
					readfloat f
					)
				"roughness multiplier": (
					readfloat f
					)
				"blend mode": (
					readlong f #unsigned
					)
				"alpha test": (
					readlong f #unsigned
					)
				"alpha test min": (
					readfloat f
					)
				"flora wind frequency": (
					readlong f #unsigned
					)
				"flora wind strength": (
					readlong f #unsigned
					)
				"tex: diffuse": (
					append g.mat.DiffuseMap (ReadFixedString f (readlong f #unsigned))
					)
				"tex: gloss": (
					append g.mat.GlossMap (ReadFixedString f (readlong f #unsigned))
					)
				"tex: normal": (
					append g.mat.NormalMap (ReadFixedString f (readlong f #unsigned))
					)
				"material priority": (
					readlong f #unsigned
					)
				"2-sided": (
					readlong f #unsigned
					)
				default: (
					format "New Block [%] Not Supported @ 0x%\n" blockstring ((bit.intAsHex p) as string)
					i = 9999 -- break loop
					)
				)
			)
		)
	fn checkData bstream str = (
		local cmp=""
		try(
			for i = 1 to 0x200 do (
				b = readbyte bstream #unsigned
				if b<0x20 do b = 0x0A
				cmp+=bit.intaschar b
				)
			)catch()
		fseek bstream 0 #seek_set
		return (matchPattern cmp pattern:("*"+str+"*"))
		)
	fn GetSkeleton = (
		local BNArr = #()  -- Declare BNArr as local

		if g != undefined do (
			fseek g 0x34 #seek_set
			local NSize = ReadLong g
			local skelnamefirts = ReadFixedString g NSize
			fseek g 0x74 #seek_cur
			local num1 = ReadLong g
			NSize = ReadLong g
			local skelname = ReadFixedString g NSize
			local null = ReadLong g
			local unk1 = ReadLong g
			local BoneCount = ReadLong g

			print BoneCount

			for a = 1 to BoneCount do (
				local BoneParent = Readlong g
				local getPos = ftell g + 18		
				local BoneName = readstring g 
				fseek g getPos #seek_set		
				fseek g 0x62 #seek_cur

				-- Read transformation matrix values
				local b11 = Readfloat g
				local b12 = Readfloat g
				local b13 = Readfloat g
				local b14 = Readfloat g
				local b21 = Readfloat g
				local b22 = Readfloat g
				local b23 = Readfloat g
				local b24 = Readfloat g
				local b31 = Readfloat g
				local b32 = Readfloat g
				local b33 = Readfloat g
				local b34 = Readfloat g
				local b41 = Readfloat g
				local b42 = Readfloat g * -1
				local b43 = Readfloat g
				local b44 = Readfloat g

				-- Create the transformation matrix
				local tfm = (quat b21 b22 b23 b24) as matrix3
				tfm.row4 = [b42, b44, b43]		
				fseek g 0x80 #seek_cur

				-- Check if the bone node already exists
				if (getNodeByName BoneName) != undefined do (
					append BNArr (getNodeByName BoneName)
					)
				if (getNodeByName BoneName) == undefined do (
					local newBone = bonesys.createbone \
						tfm.row4 \
						(tfm.row4 + 0.01 * (normalize tfm.row1)) \
						(normalize tfm.row3)

					newBone.name = BoneName
					newBone.width = 0.01
					newBone.height = 0.01
					newBone.transform = inverse tfm
					newBone.setBoneEnable false 0
					newBone.wirecolor = white
					newBone.showlinks = true
					newBone.pos.controller = TCB_position ()
					newBone.rotation.controller = TCB_rotation ()

					-- Set the parent bone if there is a parent
					if (BoneParent != -1) then (
						newBone.parent = BNArr[(BoneParent + 1)]
						)

					append BNArr newBone
					)					  
				)
			)
		)
	fn GetMaterial = (
		local found = false
		local cur = 0
		local i = 0
		local x = 0
		local str = ""
		local tex = ""
		local mat = standardmaterial()

		fseek f fsize #seek_set -- go to end of file
		found = false
		cur = fsize

		while cur > (fsize / 6) and found == false do (
			fseek f -1 #seek_cur
			if (readlong f #unsigned) == 0x6E696B73 then ( -- "skin" in hex
				Print ("Found SKIN @ 0x" + ((bit.intAsHex(ftell f)) as string))
				found = true
				) else (
				fseek f -4 #seek_cur
				)
			)

		str = ""
		
		if found == true do (
			while ftell f < fsize do (
				local b = readbyte f #unsigned
				if b < 0x20 do b = 0x0A
				str += bit.intaschar b
				)
			
			str = filterstring str ":\n"
			print str
			
			for i = 1 to str.count do (
				case str[i] of (
					"tex": (
						case str[(i+1)] of (
							" diffuse": (
								tex = folderpath + (filenameFromPath (str[(i+3)] + ".dds"))
								mat.diffuseMap = Bitmaptexture fileName:tex
								mat.diffuseMap.alphaSource = 2
								)
							" normal": (
								tex = folderpath + (filenameFromPath (str[(i+3)] + ".dds"))
								mat.specularLevel = 20
								mat.bumpMap = Normal_Bump ()
								mat.bumpMap.normal_map = Bitmaptexture fileName:tex
								mat.bumpMap.normal_map.alphaSource = 2
								)
							" gloss": (
								tex = folderpath + (filenameFromPath (str[(i+3)] + ".dds"))
								mat.glossinessMap = Bitmaptexture fileName:tex
								mat.glossinessMap.alphaSource = 2
								)
							)
						)
					"2-sided": (
						mat.twoSided = on
						)
					)
				)
			)
		
		showTextureMap mat true
		mat
		)
	fn GetMesh = (
		local vertArray=#()
		local faceArray=#()
		local Normal_array = #()
		local UVarray=#()
		local Weight_array=#()
		local B1_array=#()
		local W1_array=#()

		fseek f 0x30 #seek_set
		if (readlong f #unsigned) < 100 then (
			local NSize = ReadLong f
			local meshname = ReadFixedString f NSize
			fseek f 0x50 #seek_cur

			local check = ReadShort f
			Print ("Last Read @ 0x" + ((bit.intAsHex(ftell f)) as string))

			if check == 14516 then (
				for x = 1 to 1 do (
					fseek f 50 #seek_cur 
					local NSize3 = ReadLong f
					local meshname3 = ReadFixedString f NSize3
					fseek f 0x50 #seek_cur    
					fseek f 0x10b #seek_cur --hash    
					)
				)

			if check == 13406 then (
				for x = 1 to 1 do (
					fseek f 50 #seek_cur 
					local NSize1 = ReadLong f
					local meshname1 = ReadFixedString f NSize1
					fseek f 0x50 #seek_cur
					local check2 = ReadShort f 

					if check2 == 14516 then (
						for x = 1 to 1 do (
							fseek f 50 #seek_cur 
							local NSize2 = ReadLong f
							local meshname2 = ReadFixedString f NSize2
							fseek f 0x50 #seek_cur
							fseek f 0x6E #seek_cur --hash        
							)
						)

					if check2 == 1 then fseek f 0x68 #seek_cur        
					)
				)

			if check == 1 then fseek f 104 #seek_cur 

			local VertCount = readlong f
			local sectionCount = readlong f
			local CharCount = readlong f
			local possition = ReadFixedString f CharCount
			local null = readlong f
			local id = readlong f         

			for x = 1 to VertCount do (--vertices
				local vx = readFloat f
				local vy = readFloat f
				local vz = readFloat f    
				append vertArray ([vx,vz,vy] * mscale)
				)

			for x = 1 to sectionCount - 1 do (
				local CharCount = readlong f 
				local CharCount_fixed = (CharCount - 2) 
				print CharCount_fixed
				Print ("Last Read @ 0x" + ((bit.intAsHex(ftell f)) as string))        
				local SectionName = ReadFixedString f CharCount_fixed
				local check_w = readshort f    
				print check_w
				local null = readlong f
				local id = readlong f

				if id == 6 then (
					for x = 1 to VertCount do (--normals 6
						local nx = readFloat f
						local ny = readFloat f
						local nz = readFloat f    
						append Normal_array [nx,nz,ny]
						)
					)

				if id == 28 then (
					for x = 1 to VertCount do (--colors 28
						local ffff = readlong f        
						)
					)

				if id == 30 then (
					for x = 1 to VertCount do (--blend indices 30
						local bone1 = readbyte f #unsigned
						local bone2 = readbyte f #unsigned
						local bone3 = readbyte f #unsigned
						local bone4 = readbyte f #unsigned    
						append B1_array (Bone_Info_Struct Bone1:bone1 Bone2:bone2 Bone3:bone3 Bone4:bone4)        
						)
					)

				if id == 16 then (
					for x = 1 to VertCount do (--uv's 16
						local tu = readFloat f
						local tv = readFloat f * -1
						append UVarray [tu,tv,0]            
						)
					)

				if id == 2 then (
					if check_w == 115 then (
						for x = 1 to VertCount do (--blend weights 2
							local weight1 = readFloat f
							local weight2 = readFloat f
							local weight3 = readFloat f
							local weight4 = readFloat f    
							append W1_array (Weight_Info_Struct Weight1:weight1 Weight2:weight2 Weight3:weight3 Weight4:weight4)    
							)
						)

					for b = 1 to W1_array.count do (
						local w = (weight_data boneids:#() weights:#())
						local maxweight = 0
						if (W1_array[b].Weight1 != 0) then maxweight += W1_array[b].Weight1
						if (W1_array[b].Weight2 != 0) then maxweight += W1_array[b].Weight2
						if (W1_array[b].Weight3 != 0) then maxweight += W1_array[b].Weight3
						if (W1_array[b].Weight4 != 0) then maxweight += W1_array[b].Weight4

						if (maxweight != 0) then (
							if (W1_array[b].Weight1 != 0) then (
								local w1 = W1_array[b].Weight1 as float
								append w.boneids (B1_array[b].Bone1 + 1)
								append w.weights (w1)
								)
							if (W1_array[b].Weight2 != 0) then (
								local w2 = W1_array[b].Weight2 as float
								append w.boneids (B1_array[b].Bone2 + 1)
								append w.weights (w2)
								)
							if (W1_array[b].Weight3 != 0) then (
								local w3 = W1_array[b].Weight3 as float
								append w.boneids (B1_array[b].Bone3 + 1)
								append w.weights (w3)
								)
							if (W1_array[b].Weight4 != 0) then (
								local w4 = W1_array[b].Weight4 as float
								append w.boneids (B1_array[b].Bone4 + 1)
								append w.weights (w4)
								)      
							)
						append Weight_array w
						)
					)

				if id == 2 then (
					if check_w != 115 then (
						for x = 1 to VertCount do (--tangent/quaternion 2
							local t1 = readFloat f
							local t2 = readFloat f
							local t3 = readFloat f
							local t4 = readFloat f        
							)
						)
					)

				print id
				)

			fseek f 0x31 #seek_cur
			local faceid = ReadLong f        
			local facecount = ReadLong f        
			local totalfaces = ReadLong f    

			for x = 1 to facecount do (
				local fa = readshort f  + 1
				local fb = readshort f  + 1
				local fc = readshort f  + 1
				append faceArray [fc,fb,fa]    
				)

			local unk1 = readlong f 
			local CharCount = readlong f 
			local flag = ReadFixedString f CharCount
			local null = readlong f
			local id = readlong f

			if id == 42 then (
				for x = 1 to VertCount do (--flag 42
					local getPos = ftell f + 16
					fseek f getPos #seek_set        
					)
				)

			Print ("End of File? @ 0x" + ((bit.intAsHex(ftell f)) as string))
			local mat = undefined
			local msh = mesh vertices:vertArray faces:faceArray
			msh.name = meshname
			msh.numTVerts = UVarray.count
			buildTVFaces msh

			for j = 1 to UVarray.count do setTVert msh j UVarray[j]
			for j = 1 to faceArray.count do setTVFace msh j faceArray[j]
			for j = 1 to Normal_array.count do setNormal msh j Normal_array[j]

			if BNArr.count != 0 and Weight_array.count != 0 then (
				max modify mode
				select msh
				local skinMod = skin ()
				addModifier msh skinMod

				for i = 1 to BoneCount do (
					local maxbone = BNArr[i]
					if i != BoneCount then 
						skinOps.addBone skinMod maxbone 0
					else
						skinOps.addBone skinMod maxbone 1
					)

				modPanel.setCurrentObject skinMod

				for i = 1 to VertCount do (
					local w = Weight_array[i]
					local bi = #() --bone index array
					local wv = #() --weight value array

					for j = 1 to w.boneids.count do (
						local boneid = w.boneids[j]
						local weight = w.weights[j]
						append bi boneid
						append wv weight
						)

					skinOps.ReplaceVertexWeights skinMod i bi wv
					)
				)

			if maton == true do (
				mat = GetMaterial()
				try (
					-- Material assignment logic here
					) catch (
					print "Failed to assign material"
					)
				)

			if mat != undefined do (
				msh.material = mat
				)
			) else (
			messagebox "Not a Mesh File"
			)
		)
	fn read fsource = (
		if (fsource!=undefined) AND ((doesFileExist fsource)==true) then (
			if searchskl==true do (
				if ((getFilenamePath fsource)+(getFilenameFile fsource)+"_skeleton.ros")!= undefined do (
					g = fopen ((getFilenamePath fsource)+(getFilenameFile fsource)+"_skeleton.ros") "rb"
					try()catch()
					GetSkeleton()
					fclose g
					)
				)
			f = fopen fsource "rb"
			g = _model()
			filetype = readhashasstring f 0x20
			if (enumHashCode filetype)==#Unknown do (
				fseek f 0x10 #seek_set
				filetype = readhashasstring f 0x20
				)
			case (enumHashCode filetype) of (
				#ModelData: ( -- Model File
					readlong f #unsigned
					filename = ReadFixedString f (readlong f #unsigned)
					
					readlong f #unsigned -- ? ID, always 0
					readlong f #unsigned -- ? coumt, always 1 ?
					fseek f 0x10 #seek_cur -- Hash ID
					[(readfloat f),(readfloat f),(readfloat f)] -- scale, always [1,1,1] ?
					[(readfloat f),(readfloat f),(readfloat f),(readfloat f)] -- rotation, always [0,0,0,1] ?
					[(readfloat f),(readfloat f),(readfloat f)] -- position
					readlong f #unsigned -- always 0?
					readlong f #unsigned -- always 0?
					readlong f #unsigned -- count? always 0
		-- 			for i = 1 to (readlong f #unsigned) do ( -- count
		-- 				readfloat f --?? floats or hash
		-- 				readfloat f
		-- 				readfloat f
		-- 				readfloat f
		-- 				format "??? 0.% Data:\n\t%\n\n" i (readhashasstring f 0x20)
		-- 				readlong f #unsigned
		-- 				print ( ReadFixedString f (readlong f #unsigned) )
		-- 				readfloat f --?? floats or hash
		-- 				readfloat f
		-- 				readfloat f
		-- 				readfloat f
		-- 				[(readfloat f),(readfloat f),(readfloat f)] -- scale, always [1,1,1] ?
		-- 				[(readfloat f),(readfloat f),(readfloat f),(readfloat f)] -- rotation, always [0,0,0,1] ?
		-- 				[(readfloat f),(readfloat f),(readfloat f)] -- position	
		-- 				readlong f #unsigned
		-- 				readlong f #unsigned
		-- 				readlong f #unsigned
		-- 				readlong f #unsigned
		-- 				readlong f #unsigned
		-- 				readlong f #unsigned
		-- 				readlong f #unsigned
		-- 				)
		-- 			readlong f #unsigned
		-- 			readlong f #unsigned
		-- 			
		-- 			format "??? 1 Data:\n\t%\n\n" (readhashasstring f 0x20)
		-- 			readlong f #unsigned
		-- 			readlong f #unsigned
		-- 			readlong f #unsigned
		-- 			readbyte f #unsigned -- ?
		-- 			readlong f #unsigned
					
					fsize = getFileSize fsource -- can't decipher the blocks between :'(, cheating
					found = false
					cur =  ftell f
					
					while cur<(fsize) and found == false do (
						fseek f 1 #seek_cur
						if (enumHashCode (readhashasstring f 0x20)) == #VertexData then (
							Print ("Found VertexData @ 0x"+((bit.intAsHex(ftell f))as string))
							fseek f -0x20 #seek_cur
							found = true
							)
						else (
							fseek f -0x20 #seek_cur
							)
						cur+=1
						)
						
						
					format "Vertex Data:\n\t%\n\n" (readhashasstring f 0x20)
					readlong f #unsigned
					readlong f #unsigned
					readlong f #unsigned
					readbyte f #unsigned -- ?
					readlong f #unsigned
					vertex_count = readlong f #unsigned
					count = readlong f #unsigned
					readdatablock(count)(vertex_count)
					
					format "Face Data:\n\t%\n\n" (readhashasstring f 0x20)
					readlong f #unsigned
					readlong f #unsigned
					readlong f #unsigned
					readbyte f #unsigned -- ?
					readlong f #unsigned
					readlong f #unsigned -- primitive type?
					face_count = readlong f #unsigned
					total_faces = readlong f #unsigned
					blocksize = total_faces * 2
					blocksize += ftell f
					if (face_count*3) == total_faces then ( -- Triangle list
						for x = 1 to face_count do (
							append g.face (RH2LH [(readshort f #unsigned + 1),(readshort f #unsigned + 1),(readshort f #unsigned + 1)])
							)
						)
					else ( -- Triangle Strips
						format "Error: Face Data May be Strips\n"
						)
			-- 				fseek f blocksize #seek_set
					readlong f #unsigned
					readdatablock(1)(face_count)
					
					fseek f -0x140 #seek_end -- can't decipher the blocks between :'(, cheating
					fsize = ftell f
					found = false
					cur = fsize
					while cur>(fsize-1600) and found == false do (
						fseek f -1 #seek_cur
						if (enumHashCode (readhashasstring f 0x20)) == #MaterialData then (
							Print ("Found MaterialData @ 0x"+((bit.intAsHex(ftell f))as string))
							found = true
							)
						else (
							fseek f -0x20 #seek_cur
							)
						)
					if found==true do (
						fseek f -0x20 #seek_cur
						format "Material Data:\n\t%\n\n" (readhashasstring f 0x20)
						readlong f #unsigned
						append g.mat.name ( ReadFixedString f (readlong f #unsigned) )
						readdatablock(readlong f #unsigned)(1)
						format "Texture Count: % ? \n" (readlong f #unsigned) -- texture count?
						)
					buildObj clear_scene:chk3.checked
					)
				default: (
					if (enumHashCode filetype)!=#Unknown then (
						messagebox ("New File Type, Not Supported :'(\n\t"+(enumHashCode filetype))
						)
					else (
						messagebox ("New File Type, Not Supported :'(\n\t"+(filetype as string))
						)
					)
				)
			Print ("Last Read @ 0x"+((bit.intAsHex(ftell f))as string))
			fclose f
			)
		else (
			Print "Aborted."
			)
		)
	on ROS_IMPORTER open do (
		if (heapSize < 20000000) then heapSize = 200000000
		)
	on btn1 pressed do ( -- skeleton
		gname = getOpenFileName \
		caption:"Open .ros from Bones folder" \
		types:"Dragon's_Prophet_Bones (*_skeleton.ros)|*_skeleton.ros" \
		historyCategory:"Dragon's_ProphetObjectPresets"
		if gname!= undefined then (
			g = fopen gname "rb"
			fsize = getfilesize gname
			try()catch()
			if (checkData g "Bone") == true then (
				GetSkeleton()
				)
			else (
				if (checkData g "Position") == true then (
					f = fopen gname "rb"
					GetMesh()
					fclose f
					)
				else (
					messagebox "Failed to Load file"
					)
				)
			fclose g
			)
		else (
			Print "Skeleton Import Was Aborted"
			)
		)
	on btn2 pressed do ( -- object
		fname = getOpenFileName \
		caption:"Open .ros from Mesh folder" \
		types:"Dragon's_Prophet (*.ros)|*.ros" \
		historyCategory:"Dragon's_ProphetObjectPresets"
		if fname!= undefined then (
			f = fopen fname "rb"
			fsize = getfilesize fname
			try()catch()
			if (checkData f "Position") == true then (
				if searchskl==true do (
					if ((getFilenamePath fname)+(getFilenameFile fname)+"_skeleton.ros")!= undefined do (
						g = fopen ((getFilenamePath fname)+(getFilenameFile fname)+"_skeleton.ros") "rb"
						try()catch()
						GetSkeleton()
						fclose g
						)
					)
				GetMesh()
				)
			else (
				if (checkData f "Bone") == true then (
					messagebox "Uh... I think you selected the wrong file\nYou were meant to select a mesh file not a skeleton file...\n\nugh I'll just import it for u"
					g = fopen fname "rb"
					GetSkeleton()
					fclose g
					)
				else (
					messagebox "Failed to Load file"
					)
				)
			fclose f
			)
		else (
			Print "Mesh Import Was Aborted"
			)
		)
	on btn3 pressed do (
		read (
			getOpenFileName \
				caption:"Open .ros from Bones folder" \
				types:"Dragon's_Prophet_Bones (*.ros)|*.ros" \
				historyCategory:"Dragon's_ProphetObjectPresets"
			)
		)
	on spn1 changed val do (
		mscale = val
		)
	on chk1 changed state do (
		maton = state
		)
	on chk2 changed state do (
		searchskl=state
		if state==true then (
			btn1.enabled = false
			)
		else (
			btn1.enabled = true
			)
		)
	on edt1 entered txt do (
		if edt1!=undefined do (
			folderpath = edt1.text + "\\"
			)
		)
	)
createdialog ROS_IMPORTER