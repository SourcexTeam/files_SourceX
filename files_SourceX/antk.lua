if text == "تفعيل انطق" and Manager(msg) then
send(msg.chat_id_, msg.id_, '⌯︙اهلا عزيزي .  \n⌯︙تم تفعيل ميزة انطق')
database:del(bot_id..'SourceX:Antk:SourceX'..msg.chat_id_) 
end
if text == "تعطيل انطق" and Manager(msg) then
send(msg.chat_id_, msg.id_, '⌯︙اهلا عزيزي .  \n⌯︙تم تعطيل ميزة انطق')
database:set(bot_id..'SourceX:Antk:SourceX'..msg.chat_id_,true)  
end
if text and text:match("^انطق (.*)$") and not database:get(bot_id..'SourceX:Antk:SourceX'..msg.chat_id_) then
local UrlAntk = https.request('https://apiabs.ml/Antk.php?abs='..URL.escape(text:match("^انطق (.*)$")))
Antk = JSON.decode(UrlAntk)
if UrlAntk.ok ~= false then
download_to_file("https://translate"..Antk.result.google..Antk.result.code.."UTF-8"..Antk.result.utf..Antk.result.translate.."&tl=ar-IN",Antk.result.translate..'.mp3') 
sendAudio(msg.chat_id_, msg.id_, 0, 1,nil, './'..Antk.result.translate..'.mp3')  
os.execute('rm -rf ./'..Antk.result.translate..'.mp3')

end
end