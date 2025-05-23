--By.秋
local function Process_nil ( )
	if gg.getTargetInfo ( ) == nil then
		gg.alert ( "❌未发现Process❌" )
		os.exit ( )
	end
end


local function Process_label ( )
	if gg.getTargetInfo ( ) [ 'label' ] ~= "元气骑士" then
		gg.alert ( "❌未发现label❌" )
		os.exit ( )
	end
end


local function Process_x64 ( )
	if gg.getTargetInfo ( ) [ "x64" ] ~= true then
		gg.alert ( "❌x64~=true❌" )
		os.exit ( )
	end
end


local function IL2CPPAPI ( )
	local makeRequest = gg.makeRequest ( "http://www.byqiu.com/script/Il2cppAPI.lua" )
	if makeRequest.code ~= 200 then
		print ( "网络异常" )
		os.exit ( )
	end
	local API = pcall ( load ( makeRequest.content ) )
	if API ~= true then
		print ( "API加载异常" )
		os.exit ( )
	end
end


local function Methods_Edit ( Class , Methods , Value )
	local Methods_Instance = gg.Class_Methods ( Class , Methods )
	if not Methods_Instance or # Methods_Instance == 0 then
		return Methods_Instance
	end
		for k , v in ipairs ( Methods_Instance ) do
			gg.setValues ( { { address = v.address , flags = 4 , value = Value [ 1 ] } } )
            gg.setValues ( { { address = v.address + 0x4 , flags = 4 , value = Value [ 2 ] } } )
		end
		gg.clearList ( )
		gg.clearResults ( )
		gg.toast ( "\n修改成功" )
end


function Main ( )
	local choice = gg.choice ( {
			"血量" ,
			"护甲" ,
            "能量" ,
			"退出" ,
		} , false , "秋天科技" )
	if choice == nil then
		return nil
	end
	if choice == 1 then
		yqqs_1 ( )
	end
	if choice == 2 then
		yqqs_2 ( )
	end
	if choice == 3 then
		yqqs_3 ( )
	end
	if choice == 4 then
		os.exit ( print( "作者: By.秋\nQID: QIU01" ) )
	end
end


function yqqs_1 ( )
	local prompt = gg.prompt ( { "血量[-256;65535]" } , { "65535" } , { "number" } )
	if not prompt then
		return prompt
    end
	Methods_Edit ( "RoleAttributeProxy" , "get_hp" , { "~A8 MOV W0, #"..prompt[ 1 ] , "~A8 RET" } )
end

function yqqs_2 ( )
	local prompt = gg.prompt ( { "护甲[-256;65535]" } , { "65535" } , { "number" } )
	if not prompt then
		return prompt
    end
	Methods_Edit ( "RoleAttributeProxy" , "get_armor" , { "~A8 MOV W0, #"..prompt[ 1 ] , "~A8 RET" } )
end

function yqqs_3 ( )
	local prompt = gg.prompt ( { "能量[-256;65535]" } , { "65535" } , { "number" } )
	if not prompt then
		return prompt
    end
	Methods_Edit ( "RoleAttributeProxy" , "get_energy" , { "~A8 MOV W0, #"..prompt[ 1 ] , "~A8 RET" } )
end


UI = 0
Process_nil ( )
Process_label ( )
Process_x64 ( )
IL2CPPAPI ( )
gg.setVisible ( true )
while ( true ) do
	if gg.isVisible ( true ) then
		gg.setVisible ( false )
		if UI == 0 then
			Main ( )
		end
	end
end
