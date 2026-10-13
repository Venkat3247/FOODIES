import json
import re

transcript_path = r"C:\Users\ADMIN\.gemini\antigravity\brain\68e6e95b-ce68-4583-96e3-972d9bbb5e7e\.system_generated\logs\transcript_full.jsonl"

data_lines = []
with open(transcript_path, 'r', encoding='utf-8') as f:
    for line in f:
        obj = json.loads(line)
        if obj.get('source') == 'USER_EXPLICIT' and 'this is my food app' in obj.get('content', ''):
            content = obj['content']
            # Find the lines that look like table data
            lines = content.split('\n')
            for l in lines:
                if re.match(r'^\d+\s+\d+\s+', l.strip()):
                    data_lines.append(l.strip())
            break

print(f"Found {len(data_lines)} data lines.")

def get_image(food_name):
    f = food_name.lower()
    
    # Keyword matching
    if 'biryani' in f or 'pulao' in f or 'rice' in f or 'bath' in f or 'khichdi' in f:
        return 'images/biryani.jpg'
    
    if 'fish' in f or 'prawn' in f or 'seafood' in f or 'squid' in f or 'crab' in f or 'anjal' in f or 'kane' in f:
        return 'images/fish.jpg'
        
    if 'noodle' in f or 'manchurian' in f or 'fried rice' in f or 'chop suey' in f or 'roll' in f or 'momos' in f or 'dimsum' in f:
        return 'images/noodles.jpg'
        
    if 'pizza' in f or 'burger' in f or 'pasta' in f or 'sandwich' in f or 'cheese' in f or 'taco' in f or 'nachos' in f or 'burrito' in f:
        return 'images/pizza.jpg'
        
    if 'paneer' in f or 'veg' in f or 'gobi' in f or 'aloo' in f or 'mushroom' in f or 'dal' in f or 'chole' in f or 'palak' in f:
        return 'images/paneer.jpg'
        
    if 'dosa' in f or 'idli' in f or 'rotti' in f or 'appam' in f or 'pesarattu' in f or 'uttapam' in f:
        return 'images/masala_dosa.jpg'
        
    if 'vada' in f or 'bajji' in f or 'bonda' in f or 'buns' in f or 'puri' in f or 'kachori' in f:
        return 'images/medu_vada.jpg'
        
    if 'shawarma' in f or 'kathi' in f or 'wrap' in f or 'falafel' in f or 'hummus' in f:
        return 'images/shawarma.jpg'
        
    if 'chicken fry' in f or 'lollipop' in f or '65' in f or 'chilli chicken' in f or 'wings' in f:
        return 'images/fried_chicken.jpg'
        
    if 'chicken' in f or 'mutton' in f or 'kebab' in f or 'meat' in f or 'lamb' in f or 'beef' in f or 'roast' in f or 'sukka' in f or 'curry' in f or 'tikka' in f or 'chops' in f:
        return 'images/chicken_fry.jpg'
        
    # Default fallback
    return 'images/paneer.jpg'

sql_queries = []
for line in data_lines:
    parts = line.split('\t')
    if len(parts) >= 8:
        menuid = parts[0]
        foodname = parts[2]
        
        img = get_image(foodname)
        sql = f"UPDATE menu SET imagepath = '{img}' WHERE menuid = {menuid};"
        sql_queries.append(sql)

with open('update_images.sql', 'w', encoding='utf-8') as out:
    out.write("\n".join(sql_queries))

print(f"Generated {len(sql_queries)} update queries.")
