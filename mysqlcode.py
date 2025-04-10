import pymysql
import pandas as pd
import os

# Pad naar je map met CSV-bestanden
pad_naar_csv = r'C:\Users\Onur\OneDrive\Desktop\school\OP3\IT eurocaps'

# Database connectie (MySQL Workbench)
conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='root', 
    database='erd_erd'
)
cursor = conn.cursor()

# Import-volgorde: eerst afhankelijke tabellen legen
tabel_volgorde = [
    'retour_product',
    'kwaliteitscontrole',
    'packaging_product',
    'filling_product',
    'grinding_product',
    'leveringregel',
    'partnercontact',
    'product',
    'retour',
    'packaging',
    'filling',
    'grinding',
    'levering',
    'partner',
    'soortproduct',
    'soort_partner'
]

# Mapping van CSV naar tabelnaam
csv_bestanden = {
    "soort_partner.csv": "soort_partner",
    "partner.csv": "partner",
    "partnercontact.csv": "partnercontact",
    "soortproduct.csv": "soortproduct",
    "product.csv": "product",
    "levering.csv": "levering",
    "leveringregel.csv": "leveringregel",
    "grinding.csv": "grinding",
    "grinding_product.csv": "grinding_product",
    "filling.csv": "filling",
    "filling_product.csv": "filling_product",
    "packaging.csv": "packaging",
    "packaging_product.csv": "packaging_product",
    "retour.csv": "retour",
    "retour_product.csv": "retour_product",
    "kwaliteitscontrole.csv": "kwaliteitscontrole"
}

# Eerst alles legen in juiste volgorde
print("\n🧹 Tabellen legen...")
for tabel in tabel_volgorde:
    try:
        cursor.execute(f"DELETE FROM {tabel}")
        conn.commit()
        print(f"✅ '{tabel}' geleegd.")
    except Exception as e:
        print(f"⚠️ Fout bij legen van '{tabel}': {e}")

# Daarna vullen vanuit CSV
print("\n📥 CSV-bestanden importeren...")
for bestand, tabel in csv_bestanden.items():
    pad = os.path.join(pad_naar_csv, bestand)
    if not os.path.exists(pad):
        print(f"❌ Bestand niet gevonden: {pad}")
        continue

    df = pd.read_csv(pad)
    print(f"\n➡️ Inladen: {bestand} → {tabel}")

    for _, row in df.iterrows():
        kolommen = ', '.join(row.index)
        placeholders = ', '.join(['%s'] * len(row))
        sql = f"INSERT INTO {tabel} ({kolommen}) VALUES ({placeholders})"
        try:
            cursor.execute(sql, tuple(row))
        except Exception as e:
            print(f"⚠️ Fout bij invoegen in '{tabel}': {e}")

    conn.commit()
    print(f"✅ '{tabel}' succesvol gevuld.")

cursor.close()
conn.close()
print("\n🎉 Klaar! Alle tabellen zijn gevuld.")
