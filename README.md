# Perplexity_Clone
Build a Perplexity Clone: Flutter RAG App using FastAPI and Gemini AI


## Project Structure

```
+-------------------+        +-------------------+        +--------------------------------+
|   Flutter Client  | <----> |   FastAPI Server  | <----> |   External & Local APIs        |
|   (Mobile/Web)    |   WS   |   (Backend)       |        |                                |
+-------------------+        +-------------------+        +--------------------------------+
| - UI/UX           |        | - API Endpoints   |        | - Gemini: Content Generation   |
| - WebSocket Client|        | - WebSocket       |        | - Tavily: Search               |
+-------------------+        | - LangChain       |        | - Ollama: Local LLM            |
                             +-------------------+        +--------------------------------+
```


## Technical Reference

* [tavily](https://tavily.com/)

* [Trafilatura](https://trafilatura.readthedocs.io/en/latest/)

    Trafilatura 是一個Python 套件和命令列工具，旨在收集網路上的文字。它包括發現、提取和文字處理組件。其主要應用為網路爬取、下載、抓取以及提取主要文字、元資料和評論。

* [Pretrained Models](https://sbert.net/docs/sentence_transformer/pretrained_models.html#original-models)

    all-MiniLM-L6-v2


## Installation and Execution

Development：

```
pip install -r requirements.txt
```

Environment Variable：
```
cd perplexity/server
mkdir .env
vi .env
```

.env：

```
TAVILY_API_KEY=
GEMINI_API_KEY=
```

Python and Ollama Execution：

```
python main.py

ollama run llama2:latest
```

## Code File

### Flutter Code - lib

```
├── pages
│   ├── chat_page.dart 
│   ├── home_page.dart 
│   ├── only_llm_page.dart 
├── services
│   ├── chat_web_service.dart
│   ├── llama_chat_web_service.dart
├── theme
│   ├── colors.dart               -> Color Settings
├── widgets
│   ├── answer_section.dart
│   ├── only_llm_search.dart
│   ├── search_bar_button.dart  
│   ├── search_section.dart 
│   ├── side_bar.dart 
│   ├── side_bar_button.dart
│   ├── sources_section.dart
└── main.dart 

```

### FastAPI Code - server

```
├── server
│   ├── pydantic_models
│   │   ├── chat_body.py
│   ├── services
│   │   ├── config.py
│   │   ├── llm_service.py
│   │   ├── search_service.py
│   │   ├── sort_source_service.py
│   ├── .env
│   ├── requirements.txt 
└── main.dart 
```



## Example

http://0.0.0.0:8000/docs#

```

What is Resident Evil's latest work?

Who is the President of the United States now?

Who is Ave Mujica？

```
* Who is Ave Mujica？

```
----------------------- Query -----------------------
Who is ave mujica ？
----------------------- Only LLM Generate Response -----------------------
There seems to be a typo in your question. Did you mean **"Have I met you?"** or were you referring to a specific person? If you meant a person, could you double-check the name?

----------------------- Search Results -----------------------
sorted_results len : 2
https://kprofiles.com/ave-mujica-members-profile-and-facts/
https://bandori.fandom.com/wiki/Ave_Mujica
======================= LLM Generate_Response =======================
Ave Mujica is a Japanese all-girl band within the BanG Dream! franchise (Source 1, Source 2). They debuted on April 11, 2023, with the song "Kuro no Birthday" (Source 1). An anime featuring Ave Mujica is set to begin airing on January 2, 2025 (Source 2).

The band consists of five members (Source 1, Source 2):

*   **Doloris / Uika Misumi:** Guitarist, Vocalist (Source 1, Source 2). Portrayed by Sasaki Riko (Source 1).
*   **Mortis / Mutsumi Wakaba:** Guitarist (Source 1, Source 2). Portrayed by Watase Yuzuki (Source 1).
*   **Timoris / Umiri Yahata:** Bassist (Source 1, Source 2). Portrayed by Okada Mei (Source 1).
*   **Amoris / Nyamu Yutenji:** Drummer (Source 1, Source 2). Portrayed by Akane Yonezawa (Source 1).
*   **Oblivionis / Sakiko Togawa:** Keyboardist (Source 1, Source 2). Portrayed by Takao Kanon (Source 1).

The band was formed by Sakiko Togawa (Oblivionis), the keyboardist and leader of the now-disbanded CRYCHIC. She recruited members from diverse backgrounds to create Ave Mujica, aiming for a quick major debut (Source 2).

The members use stage names (Doloris, Mortis, Timoris, Amoris, Oblivionis), which are derived from features of the Moon's surface, specifically lunar lacūs ("lakes") and one sinus ("bay") (Source 2). The members' surnames are based on railway stations across Japan (Source 2). Ave Mujica's name derives from "Ave Musica," which means "Hail the Music" in Latin (Source 2).
```

## websocket Example

```
ws://localhost:8000/ws/chat

ws://localhost:8000/ws/chat_llama
```

### ws/chat

* Query:

```
{
  "query": "Who is Ave Mujica ？"
}
```

* Response:

```
{
    "type": "search_result",
    "data": [
        {
            "title": "Ave Mujica Members Profile and Facts (Updated!) - Kpop Profiles",
            "url": "https://kprofiles.com/ave-mujica-members-profile-and-facts/",
            "content": "Ave Mujica Members Profile and Facts\nAve Mujica is a Japanese 5 member girl band from the BanG Dream! franchise. They debuted on April 11, 2023 with the song “Kuro no Birthday”.\nAve Mujica SNS:\nOfficial Website: avemujica.bang-dream.com\nTwitter: BDP_AveMujica\nYouTube: Ave Mujica\nAve Mujica Members:\nSasaki Riko\nPlays: Doloris / Uika Misumi\nPosition: Guitarist, Vocalist\nBirthday: November 10, 1997\nZodiac Sign: Scorpio\nBirthplace: Akita, Japan\nBlood Type: A\nHeight: 150 cm (4’11”)\nWebsite: sasakirico.com\nTwitter: sasakirico\nInstagram: sasakirico_official\nYouTube: sasakirico\nSasaki Rico Facts:\n– She is a member of Re-connect.\n– She is also a member of sumimi, playing the same character.\n– She previously went under the name Rico.\n– She also voices Daia in Kiratto Pri☆Chan, Poporon in Dropkick on My Devil! and Kyoko in Crane Game Girls.\nWatase Yuzuki\nPlays: Mortis / Mutsumi Wakaba\nPosition: Guitarist\nBirthday: February 18, 2003\nZodiac Sign: Aquarius\nBirthplace: Chiba, Japan\nHeight: 153 cm (5’0″)\nBlood Type: O\nTwitter: Watase_Yuzuki\nWatase Yuzuki Facts:\n– She is a member of Lyrical Lily, playing Takeshita Miiko.\n– She is a former member of Sakki no Onnanoko.\n– She can play the electone.\n– She is ambidextrous.\n– Her hobbies are taking photos, singing and making sweets.\n– She loves Disney.\n– She hates ghosts and is easily frightened.\nOkada Mei\nPlays: Timoris / Umiri Yahata\nPosition: Bass\nBirthday: May 19, 1996\nZodiac Sign: Taurus\nBirthplace: Fukaya, Saitama, Japan\nBlood Type: O\nHeight: 161 cm (5’3″)\nTwitter: okada_mei0519\nInstagram: mei_okada0519\nOkada Mei Facts:\n– She is a member of Merm4id, playing Mizushima Marika.\n– Her favourite genre of anime is slice-of-life.\n– She is a former member of Tenkou Shoujo*.\n– She was on the soft tennis team in school.\n– Her hobbies are playing tennis and drawing.\n– She often posts her illustrations on Instagram.\nAkane Yonezawa\nPlays: Amoris / Nyamu Yutenji\nPosition: Drummer\nBirthday: December 31\nBirthplace: Tottori, Japan\nBlood Type: A\nHeight: 160 cm (5’2″)\nTwitter: AkaneY_banu\nInstagram: akaneyonezawa.banu\nYouTube: Akane Yonezawa\nAkane Yonezawa Facts:\n– Her hobbies are cooking, drumming and watching anime.\n– Her talents are drumming and singing while playing the drums.\nTakao Kanon\nPlays: Oblivionis / Sakiko Togawa\nPosition: Keyboardist\nBirthday: September 10, 2002\nZodiac Sign: Virgo\nBirthplace: Tokyo, Japan\nBlood Type: O\nHeight: 152 cm (5’0″)\nTwitter: Kanon_Takao\nTakao Kanon Facts:\n– She is a former member of Earth Star Dream.\n– She is a member of Sunny Peace, playing Chisa Shiraishi.\n– Her hobbies are reading and doing ballet.\n– She has an older brother, Sonosuke Takao, who is a composer and pianist.\n– Her favourite animes are K-ON!, Charlotte, Clannad and Yama no Susume.\n– She learned to play the piano from a young age and achieved the highest ranking at the 2013 International PianoTalents Competition in Milan.\n– In 2014, when she was 12, she won the National Voice Actor Grand Prix. She was one of the 9 winners out of 3000 applicants.\n– She also voiced Goha Yuna in Yu-Gi-Oh! Go Rush!!, Kasumi Yashiro in Muv-Luv Alternative and Hermit Mio in Edens Zero.\nmade by cutieyoomei\nLatest Release:",
            "relevance_sore": 0.5279330611228943
        },
        {
            "title": "Ave Mujica | BanG Dream! Wikia | Fandom",
            "url": "https://bandori.fandom.com/wiki/Ave_Mujica",
            "content": "|\n- This page is for Ave Mujica. For the song of the same name, see Ave Mujica (song).\n| “ | Welcome... to the world of Ave Mujica. | ” |\nAve Mujica is an all-girl band in the BanG Dream! franchise. The group consists of five members, namely Misumi Uika (Doloris) on lead guitar and vocals, Wakaba Mutsumi (Mortis) on rhythm guitar, Yahata Umiri (Timoris) on bass, Yuutenji Nyamu (Amoris) on drums, and Togawa Sakiko (Oblivionis) on keyboard.\nSimilarly to MyGO!!!!! before MyGO!!!!! 4th LIVE, Ave Mujica's band members were unknown and hid their faces while performing. During Ave Mujica 0th LIVE, they also wore cloaks until the last song. In-universe the members' identities were revealed during the 13th episode of BanG Dream! It's MyGO!!!!!, while their voice actresses made tweets officially announcing themselves as Ave Mujica's members after the episode's airing.\nOn September 14, 2023, it was announced that Ave Mujica would be getting their own anime.[1] On October 17, 2024, it was announced that the anime would start airing on January 2, 2025.\nBackground[]\nAve Mujica is a band crafted by Sakiko, or Oblivionis, the keyboardist and leader of the now disbanded CRYCHIC. It comprises of 5 members coming from various but seemingly alike backgrounds, either coming from a wealthy family, being the daughter of celebrities or being celebrities themselves. After the young woman seemingly broke, leading to CRYCHIC's disbandment, it appears that Sakiko has decided to create another band from the ground up, grabbing 2 of her childhood friends and 2 other people with her to create Ave Mujica.\nSakiko invited each member individually, contacting them to meet her before offering them to join the band. She aimed to make their band the band with the quickest major debut.[2]\nSongs[]\n- Kuro no Birthday\n- Futatsu no Tsuki ~Deep Into The Forest~\n- Choir ‘S’ Choir\n- Kamisama, Baka\n- Mas?uerade Rhapsody Re?uest\n- Ave Mujica (song)\n- Subarashiki Sekai demo Dokonimonai Basho\n- Angles\n- Symbol I: △\n- Symbol II: 🜁\n- Symbol III: ▽\n- Symbol IV: 🜃\n- Ether\n- KiLLKiSS\n- Georgette Me, Georgette You\n- DIVINE\n- Imprisoned XII\n- Crucifix X\n- Hachibousei Dance\n- Kao\n- Sora no Música\nLives/Events[]\n- Ave Mujica 0th LIVE\n- Ave Mujica 1st LIVE\n- Ave Mujica 2nd LIVE\n- Ave Mujica 3rd LIVE\n- Ave Mujica 4th LIVE\n- Ave Mujica Special Live \"KiLLKiSS\"\n- Wakaremichi no, Sono Saki e (with MyGO!!!!!)\n- Ave Mujica 5th LIVE\n- BanG Dream! 10th Anniversary LIVE\nVideos[]\nTrivia[]\n- Ave Mujica's name derives from \"Ave Musica\", which in Latin means \"Hail the Music\".\n- Ave Maria (Hail Mary) is a traditional Christian prayer addressed to the mother of Christ.\n- Mujina is the Japanese word for \"badger,\" trickster animals aligned with tanuki and kitsune.\n- Musically, Ave Mujika is officially described by both the creators and music media as an all-female heavy metal or gothic metal band. Since the franchise already had a band that performed music in these genres, it was decided at the concept stage to give the band a deeper, more emotionally passionate and visually striking concept to further distinguish it.[4]\n- They are the second band in the series whose members use stage names.\n- Kitschy and creepy, yet thrilling and cute, the band's visual aesthetic was inspired by the iconic director of macabre films, Tim Burton.[4]\n- The members' surnames (Misumi, Wakaba, Yahata, Yuutenji, and Togawa) are all based on railway stations found across Japan.\n- The members' stage names are derived from the features of the Moon's surface, similar in nature to the larger lunar maria (\"Moon seas\"): four lacūs (singular: lacus, plural: lacūs) (\"lakes\") and one sinus (singular: sinus, plural: sinūs) (\"bay\"). Lunar maria are large, dark basaltic plains on the Moon that were formed by lava flowing into ancient impact basins. They were called maria (singular: mare, plural: maria) by early astronomers who mistook them for actual seas.\n- Doloris — named after Lacus Doloris, meaning \"Lake of Sorrow\".\n- Mortis — named after Lacus Mortis, meaning \"Lake of Death\".\n- Timoris — named after Lacus Timoris, meaning \"Lake of Fear\".\n- Amoris — named after Sinus Amoris, meaning \"Bay of Love\".\n- Oblivionis — named after Lacus Oblivionis, meaning \"Lake of Forgetfulness\".\nReferences[]\nExternal Links[]\n- https://bang-dream.com/avemujica\n- https://avemujica.bang-dream.com/\n- https://twitter.com/bdp_avemujica\n- https://twitter.com/bangdream_en\n- https://twitter.com/bangdream_la\n- https://www.youtube.com/channel/UCrWC59UUMETuCp9IYUdjVbg\n- https://lin.ee/d7B7l5p\n- https://m.blog.naver.com/PostList.naver?blogId=bang_dream_kr&tab=1 - Official Ave Mujica Korean blog\n[]\n|",
            "relevance_sore": 0.5035886168479919
        }
    ]
}


{
  "type":"llm_response",
  "data":"Ave Mujica is a five-member all-girl band from the BanG Dream! franchise. Here's a breakdown of key information about them, based on the provided sources:\n\n*   **Debut:** They debuted on April 11, 2023, with the song \"Kuro no Birthday\" (Source 1).\n*   **Members and Roles (Character/Voice Actress):** (Source 1, Source 2)\n    *   Doloris / Uika Misumi: Guitarist, Vocalist (Played by Sasaki Riko)\n    *   Mortis / Mutsumi Wakaba: Guitarist (Played by Watase Yuzuki)\n    *   Timoris / Umiri Yahata: Bass (Played by Okada Mei)\n    *   Amoris / Nyamu Yutenji: Drummer (Played by Akane Yonezawa)\n    *   Oblivionis / Sakiko Togawa: Keyboardist (Played by Takao Kanon)\n*   **Background:** Ave Mujica was created by Sakiko Togawa (Oblivionis), the keyboardist and leader of the disbanded CRYCHIC. Sakiko invited members individually, aiming for a quick major debut. Members come from similar backgrounds such as wealthy families or being celebrities themselves (Source 2).\n*   **Anime:** Ave Mujica is getting their own anime, scheduled to start airing on January 2, 2025 (Source 2).\n*   **Music Style:** Ave Mujica is officially described as an all-female heavy metal or gothic metal band (Source 2).\n*   **Stage Names:** Ave Mujica is the second band in the series whose members use stage names (Source 2). The members' stage names are derived from features of the Moon's surface: Lacus Doloris (Lake of Sorrow), Lacus Mortis (Lake of Death), Lacus Timoris (Lake of Fear), Sinus Amoris (Bay of Love), and Lacus Oblivionis (Lake of Forgetfulness) (Source 2).\n*   **Name Origin:** The name \"Ave Mujica\" derives from \"Ave Musica\", which means \"Hail the Music\" in Latin (Source 2).\n*   **Visual Aesthetic:** The band's visual aesthetic is inspired by Tim Burton (Source 2).\n\nIn summary, Ave Mujica is a complex and visually striking band within the BanG Dream! universe, characterized by its heavy metal sound, thematic depth, and the mysterious backgrounds of its members.\n",
}
```

### ws/chat_llama

* Query:

```
{
  "query": "Who is the President of the United States now?"
}
```
* Response:

```
{
  "type":"llm_response",
  "data":"The current President of the United States is Joe Biden. He was inaugurated as the 46th President of the United States on January 20, 2021."
}
```

## To-do

Additional functions

 - [x] Only the local LLM（ Llama2 ）is used for searching.
 - [ ] Change the local LLM.
 - [ ] local LLM -> RAG search.

Modify

 - [ ] Config File
 - [ ] Flutter Life Cycle
