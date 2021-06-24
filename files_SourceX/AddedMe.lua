--[[
BY : TshAkETEAM
Channel Files : https://t.me/tshakeFiles
]]
local function keko_tshake(data)
    local msg = data.message_
    redis = (loadfile "./File_Libs/redis.lua")()
    database = Redis.connect('127.0.0.1', 6379)
    sudos = dofile('sudo.lua')
    JSON = (loadfile  "./File_Libs/dkjson.lua")()
    bot_id_keko = {string.match(token, "^(%d+)(:)(.*)")}
    bot_id = tonumber(bot_id_keko[1])

    function is_creator(msg)
    user_id = msg.sender_user_id_
    chat_id = msg.chat_id_
    local var = false
    local creator = database:sismember('tshake:'..bot_id..'creator:'..chat_id, user_id) 
    local admin = database:sismember('tshake:'..bot_id..'admins:', user_id)
    if creator then var = true end
    if admin then var = true end
    for k,v in pairs(sudo_users) do
    if user_id == v then var = true end end
    local keko_add_sudo = redis:get('tshake:'..bot_id..'sudoo'..user_id..'')
    if keko_add_sudo then var = true end
    return var
    end

    local function send(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
    local TextParseMode = {ID = "TextParseModeMarkdown"}
    tdcli_function ({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = 1,
    reply_markup_ = nil,
    input_message_content_ = {
    ID = "InputMessageText",
    text_ = text,
    disable_web_page_preview_ = disable_web_page_preview,
    clear_draft_ = 0,
    entities_ = {},
    parse_mode_ = TextParseMode,
    },
    }, dl_cb, nil)
    end

    local msg = data.message_
    text = msg.content_.text_
    if is_creator(msg) then 
    if text and text == "تعطيل ضافني" then 
    database:set("tshake:loock:add:w:"..msg.chat_id_..bot_id,"tshake")
    send(msg.chat_id_, msg.id_, 1, "🔘┇ تم تعطيل خاصيه ضافني", 1, 'html')
    return "keko"
    end 
    if text and text == "تفعيل ضافني" then 
    database:del("tshake:loock:add:w:"..msg.chat_id_..bot_id)
    send(msg.chat_id_, msg.id_, 1, "☑️┇ تم تفعيل خاصيه ضافني", 1, 'html')
    return "keko"
    end 
    end
    if not database:get("tshake:loock:add:w:"..msg.chat_id_..bot_id) then 
    if msg.content_.ID == "MessageChatAddMembers" then
    database:set("tshake:add:me:w:"..bot_id..msg.chat_id_..msg.content_.members_[0].id_,msg.sender_user_id_)    
    end 
    if text and text:match("(.*)(ضافني)(.*)") then 
    if_keko =  database:get("tshake:add:me:w:"..bot_id..msg.chat_id_..msg.sender_user_id_)    
    if not if_keko then 
    send(msg.chat_id_, msg.id_, 1, '🔖┇انته دخلت عل رابط لتلح', 1, "html")
    else
    local id = if_keko
    local text = '🔘┇هاذا الضافك هنا .'
    tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
    end
    end
    end
    end
    return {
        keko_tshake = keko_tshake,
    }
    --[[
    BY : TshAkETEAM
    Channel Files : https://t.me/tshakeFiles
    ]]
    
