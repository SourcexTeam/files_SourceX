
local function SourceXe(msg)
local text = msg.content_.text_
if text then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local SourceXChengName = database:get(bot_id.."SourceX:Cheng:Name"..data.id_)
if not data.first_name_ then 
if SourceXChengName then 
send(msg.chat_id_, msg.id_, "        ["..SourceXChengName..']')
database:del(bot_id.."SourceX:Cheng:Name"..data.id_) 
end
end
if data.first_name_ then 
if SourceXChengName ~= data.first_name_ then 
local Text = {
  '     ',
  "    ",
  "     ",
  '    ', 
  '     '
 } 
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."SourceX:Cheng:Name"..data.id_, data.first_name_) 
end
end
end
end,nil)   
end

end
return {SourceX = SourceXe}
